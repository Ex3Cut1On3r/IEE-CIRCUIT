class Env {
  // You can override at runtime:
  // flutter run --dart-define=HG_BASE_URL=http://x.x.x.x:8000
  static const String baseUrl = String.fromEnvironment(
    'HG_BASE_URL',
    defaultValue: 'http://93.115.17.216:8000',
  );

  static Uri apiUri(String path) => Uri.parse('$baseUrl$path');

  static Uri wsUri(String path) {
    final u = Uri.parse(baseUrl);
    final scheme = (u.scheme == 'https') ? 'wss' : 'ws';
    return Uri(
      scheme: scheme,
      host: u.host,
      port: u.hasPort ? u.port : null,
      path: path,
    );
  }
}
