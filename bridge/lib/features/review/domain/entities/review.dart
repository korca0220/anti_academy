class Review {
  const Review({
    required this.id,
    required this.transactionId,
    required this.roomId,
    required this.reviewerId,
    required this.revieweeId,
    required this.rating,
    this.comment,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String transactionId;
  final String roomId;
  final String reviewerId;
  final String revieweeId;
  final int rating;
  final String? comment;
  final DateTime createdAt;
  final DateTime updatedAt;

  // TODO: freezed + fromJson/toJson 매핑 도입
}
