class Dimensions {
  double? _width;
  double? _height;
  double? _depth;

  Dimensions({
    double? width,
    double? height,
    double? depth,
  }) {
    _width = width ?? 0.0;
    _height = height ?? 0.0;
    _depth = depth ?? 0.0;
  }

  Map<String, dynamic> toJson() {
    return {
      'width': _width,
      'height': _height,
      'depth': _depth,
    };
  }

  factory Dimensions.fromJson(Map<String, dynamic> json) {
    if (json == null) throw Exception("Dimensions JSON is null");
    return Dimensions(
      width: (json['width'] ?? 0).toDouble(),
      height: (json['height'] ?? 0).toDouble(),
      depth: (json['depth'] ?? 0).toDouble(),
    );
  }
}
