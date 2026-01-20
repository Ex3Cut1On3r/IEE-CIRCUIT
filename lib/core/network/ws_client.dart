import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../config/env.dart';

/// Robust WS client with auto reconnect + broadcast stream.
class WsClient {
  WsClient({required this.path});

  final String path;

  WebSocketChannel? _channel;
  StreamSubscription? _sub;

  final _controller = StreamController<Map<String, dynamic>>.broadcast();
  Stream<Map<String, dynamic>> get stream => _controller.stream;

  bool _manuallyClosed = false;
  bool _connected = false;
  bool get isConnected => _connected;

  Future<void> connect() async {
    _manuallyClosed = false;
    await _open();
  }

  Future<void> close() async {
    _manuallyClosed = true;
    _connected = false;
    await _sub?.cancel();
    await _channel?.sink.close();
    _channel = null;
  }

  Future<void> _open() async {
    if (_manuallyClosed) return;

    final uri = Env.wsUri(path);

    try {
      _channel = WebSocketChannel.connect(uri);
      _connected = true;

      _sub = _channel!.stream.listen(
            (event) {
          try {
            final data = jsonDecode(event as String);
            if (data is Map<String, dynamic>) {
              _controller.add(data);
            }
          } catch (_) {}
        },
        onDone: () async {
          _connected = false;
          await _reconnect();
        },
        onError: (_) async {
          _connected = false;
          await _reconnect();
        },
        cancelOnError: true,
      );
    } catch (_) {
      _connected = false;
      await _reconnect();
    }
  }

  Future<void> _reconnect() async {
    if (_manuallyClosed) return;

    // simple exponential backoff
    int delayMs = 500;
    for (int i = 0; i < 8; i++) {
      if (_manuallyClosed) return;
      await Future.delayed(Duration(milliseconds: delayMs));
      try {
        await _sub?.cancel();
        await _channel?.sink.close();
      } catch (_) {}
      _channel = null;

      await _open();
      if (_connected) return;

      delayMs = (delayMs * 2).clamp(500, 8000);
    }
  }
}
