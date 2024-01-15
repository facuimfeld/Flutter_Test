class TennisCourt {
  String name;
  String photoUrl;
  bool lights;

  TennisCourt({
    required this.name,
    required this.photoUrl,
    required this.lights,
  });

  factory TennisCourt.fromJson(Map<String, dynamic> json) {
    return TennisCourt(
      name: json['name'],
      photoUrl: json['photoUrl'],
      lights: json['lights'],
    );
  }

  Map<String, Object?> toMap() {
    return {
      'name': name,
      'photoUrl': photoUrl,
      'lights': lights == true ? '1' : 0,
    };
  }

  factory TennisCourt.fromMap(Map<String, dynamic> json) {
    return TennisCourt(
        name: json["name"],
        photoUrl: json["photoUrl"],
        lights: json["lights"] == '1' ? true : false);
  }
}
