class ApiModel {
  String? question;
  int? solution;

  ApiModel({this.question, this.solution});

  factory ApiModel.fromJson(Map<String, dynamic> json) => ApiModel(
        question: json['question'] as String?,
        solution: json['solution'] as int?,
      );
}
