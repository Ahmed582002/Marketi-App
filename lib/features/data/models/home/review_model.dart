import 'package:store/core/api/end_ponits.dart';

class ReviewModel {
  int? rating;
  String? comment;
  String? date;
  String? reviewerName;
  String? reviewerEmail;

  ReviewModel({
    this.rating,
    this.comment,
    this.date,
    this.reviewerName,
    this.reviewerEmail,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      rating: json[ApiKey.reviewRating],
      comment: json[ApiKey.reviewComment],
      date: json[ApiKey.reviewDate],
      reviewerName: json[ApiKey.reviewReviewerName],
      reviewerEmail: json[ApiKey.reviewReviewerEmail],
    );
  }
}
