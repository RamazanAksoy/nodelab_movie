abstract class ProfileEvent {}

class FetchProfile extends ProfileEvent {}

class UploadPhoto extends ProfileEvent {
  final String filePath;
  UploadPhoto(this.filePath);
}
