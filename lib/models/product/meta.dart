class Meta {
  String? _createdAt;
  String? _updatedAt;
  String? _barcode;
  String? _qrCode;

  Meta({
    String? createdAt,
    String? updatedAt,
    String? barcode,
    String? qrCode,
  }) {
    _createdAt = createdAt ?? '';
    _updatedAt = updatedAt ?? '';
    _barcode = barcode ?? '';
    _qrCode = qrCode ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': _createdAt,
      'updatedAt': _updatedAt,
      'barcode': _barcode,
      'qrCode': _qrCode,
    };
  }

  factory Meta.fromJson(Map<String, dynamic> json) {
    if (json == null) throw Exception("Meta JSON is null");
    return Meta(
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      barcode: json['barcode'] ?? '',
      qrCode: json['qrCode'] ?? '',
    );
  }
}
