class LoginRespond {
  bool success;
  String message;
  String token;
  LoginRespond({
    required this.success,
    required this.message,
    required this.token,
  });
  factory LoginRespond.fromJson(Map<String,dynamic>json){
    return LoginRespond(
      success:json["success"],
      message:json["message"],
      token:json["token"],
    );
  }
}