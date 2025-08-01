import '../../../core/base/model/IResponseModel.dart';
import '../../../core/base/service/base_service.dart';
import '../../../core/constants/enums/http_request_enum.dart';
import '../../../product/network/service_extension.dart';
import '../../login/model/user.dart';
import '../model/register_request.dart';

class RegisterService with BaseService {
  Future<IResponseModel<UserResponse?>?> register(RegisterRequest? request) async {
    final response = await networkManager?.send<UserResponse, UserResponse>(
      ServicePathEnum.register.rawValue,
      parseModel: UserResponse(),
      type: HttpTypes.POST,
      data: request?.toJson(),
    );
    return response;
  }
}
