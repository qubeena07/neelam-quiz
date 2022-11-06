class UserModel {
  String? refresh;
  String? access;

  UserModel({this.refresh, this.access});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        refresh: json['refresh'] as String?,
        access: json['access'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'refresh': refresh,
        'access': access,
      };
}
