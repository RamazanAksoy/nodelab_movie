enum ServicePathEnum { login, register }

extension ServiceAdressPath on ServicePathEnum {
  String get rawValue {
    switch (this) {
      case ServicePathEnum.login:
        return "user/login";

      case ServicePathEnum.register:
        return "user/register";
    }
  }
}
