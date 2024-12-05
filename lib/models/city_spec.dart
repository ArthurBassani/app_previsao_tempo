class CitySpec {
  final String name, timezone, country;
  final double latitude, longitude;

  CitySpec({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.country,
  });

  factory CitySpec.fromJson(Map<String, dynamic> json) => CitySpec(
        name: json['name'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        timezone: json['timezone'],
        country: json['country'],
      );
}
