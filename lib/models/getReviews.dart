// ignore_for_file: file_names

class GetReviewsModel {
  double? rate;
  String? review;

  GetReviewsModel({
    this.rate,
    this.review,
  });

  GetReviewsModel.fromJson(Map<String, dynamic> json) {
    rate = json['rate'];
    review = json['review'];
  }
}
