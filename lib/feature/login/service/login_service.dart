import '../../../../core/base/model/IResponseModel.dart';
import '../model/login_request.dart';
import '../model/user.dart';
import '/core/base/service/base_service.dart';
import '/product/network/service_extension.dart';

import '../../../../core/constants/enums/http_request_enum.dart';

class LoginService with BaseService {
  Future<IResponseModel<UserResponse?>?> login(LoginRequest? loginRequest) async {
    final response = await networkManager?.send<UserResponse, UserResponse>(
      ServicePathEnum.login.rawValue,
      parseModel: UserResponse(),
      type: HttpTypes.POST,
      data: loginRequest?.toJson(),
    );
    return response;
  }
}
