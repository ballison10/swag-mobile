part of 'update_profile_bloc.dart';

@freezed
class UpdateProfileEvent with _$UpdateProfileEvent {

  const factory UpdateProfileEvent.update(UpdateProfilePayloadModel model) =
      _UpdateProfileEvent;
  const factory UpdateProfileEvent.updateAvatar(
      Uint8List bytes, String imageTopic, String topicId) = _UpdateAvatarEvent;
  const factory UpdateProfileEvent.importData() = _importDataEvent;
  const factory UpdateProfileEvent.askEmailVerification() = _AskEmailVerification;
  const factory UpdateProfileEvent.closeVerifyEmailModal() = _CloseVerifyEmailModal;
  const factory UpdateProfileEvent.updateName(UpdateProfilePayloadModel model) =
  _UpdateProfileNameEvent;
}
