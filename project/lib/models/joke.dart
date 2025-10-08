class Joke {
  final String id;
  final String value;
  final String? iconUrl;
  final String? url;

  Joke({
    required this.id,
    required this.value,
    this.iconUrl,
    this.url,
  });

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      id: json['id'] as String,
      value: json['value'] as String,
      iconUrl: json['icon_url'] as String?,
      url: json['url'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'value': value,
        'icon_url': iconUrl,
        'url': url,
      };
}
