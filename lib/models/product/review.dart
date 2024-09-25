class Review {
  int? _rating;
  String? _comment;
  String? _date;
  String? _reviewerName;
  String? _reviewerEmail;

  Review({
    int? rating,
    String? comment,
    String? date,
    String? reviewerName,
    String? reviewerEmail,
  }) {
    _rating = rating ?? 0;
    _comment = comment ?? '';
    _date = date ?? '';
    _reviewerName = reviewerName ?? '';
    _reviewerEmail = reviewerEmail ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'rating': _rating,
      'comment': _comment,
      'date': _date,
      'reviewerName': _reviewerName,
      'reviewerEmail': _reviewerEmail,
    };
  }

  factory Review.fromJson(Map<String, dynamic> json) {
    if (json == null) throw Exception("Review JSON is null");
    return Review(
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
      date: json['date'] ?? '',
      reviewerName: json['reviewerName'] ?? '',
      reviewerEmail: json['reviewerEmail'] ?? '',
    );
  }
}
