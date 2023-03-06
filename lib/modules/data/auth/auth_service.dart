import 'package:swagapp/modules/constants/constants.dart';
import 'package:swagapp/modules/models/auth/generic_response_model.dart';
import 'package:swagapp/modules/pages/login/create_account_page.dart';

import '../../api/api.dart';
import '../../api/api_service.dart';
import '../../models/auth/create_account_payload_model.dart';
import 'i_auth_service.dart';

class AuthService extends IAuthService {
  AuthService(this.apiService);

  final APIService apiService;

  @override
  Stream<String?> subscribeToAuthChanges() => Stream.value(null);

  @override
  Future<GenericResponseModel> authenticate(
      String email, String password) async {
    final response = await apiService.getEndpointData(
      endpoint: Endpoint.login,
      method: RequestMethod.post,
      body: {"password": password, "email": email, "deviceId": defaultString},
      fromJson: (json) => GenericResponseModel.fromJson(json),
    );
    return response;
  }

  @override
  Future<GenericResponseModel> createAccount(
      CreateAccountPayloadModel model) async {
    final response = await apiService.getEndpointData(
      endpoint: Endpoint.createNewAccount,
      method: RequestMethod.post,
      body: model.toJson(),
      fromJson: (json) => GenericResponseModel.fromJson(json),
    );
    return response;
  }

  @override
  Future<void> logOut() async {}

  @override
  Future<bool> isUsernameAvailable(String username) async {
    String response = await apiService.getEndpointData(
      endpoint: Endpoint.isUsernameAvailable,
      method: RequestMethod.post,
      dynamicParam: username,
      fromJson: (json) => json,
    );
    return response.parseBool();
  }
}
