class Config {
  final String baseUrl;
  final String? apiKey;
  final bool? enableDebugging;

  Config({
    required this.baseUrl,
    this.apiKey,
    this.enableDebugging,
  });
}
