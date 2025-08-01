import '../../../core/base/model/base_model.dart';

class UserResponse extends BaseModel<UserResponse> {
  final ResponseInfo? response;
  final User? data;

  UserResponse({this.response, this.data});

  factory UserResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return UserResponse();
    return UserResponse(response: ResponseInfo.fromJson(json['response']), data: User.fromJson(json['data']));
  }

  Map<String, dynamic> toJson() => {'response': response?.toJson(), 'data': data?.toJson()};

  @override
  UserResponse fromJson(Map<String, dynamic> json) {
    return UserResponse.fromJson(json);
  }
}

class ResponseInfo {
  final int? code;
  final String? message;

  ResponseInfo({this.code, this.message});

  factory ResponseInfo.fromJson(Map<String, dynamic>? json) {
    if (json == null) return ResponseInfo();
    return ResponseInfo(code: json['code'] as int?, message: json['message'] as String?);
  }

  Map<String, dynamic> toJson() => {'code': code, 'message': message};
}

class User {
  final String? id;
  final String? name;
  final String? email;
  final String? photoUrl;
  final String? token;

  User({this.id, this.name, this.email, this.photoUrl, this.token});

  factory User.fromJson(Map<String, dynamic>? json) {
    if (json == null) return User();
    return User(
      id: json['id'] ?? json['_id'],
      name: json['name'] as String?,
      email: json['email'] as String?,
      photoUrl: json['photoUrl'] as String?,
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'email': email, 'photoUrl': photoUrl, 'token': token};
}
