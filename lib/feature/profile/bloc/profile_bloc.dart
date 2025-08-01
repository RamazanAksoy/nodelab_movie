import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'profile_event.dart';
import 'profile_state.dart';
import '../service/profile_service.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileService service;

  ProfileBloc(this.service) : super(ProfileState()) {
    on<FetchProfile>(_onFetchProfile);
    on<UploadPhoto>(_onUploadPhoto);
  }

  Future<void> _onFetchProfile(FetchProfile event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: ProfileStatus.loading));

    final userResult = await service.fetchProfile();
    final favResult = await service.fetchFavoriteMovies();

    if (userResult?.data != null && favResult?.data?.data != null) {
      emit(state.copyWith(status: ProfileStatus.success, user: userResult!.data, favorites: favResult!.data!.data!));
    } else {
      emit(state.copyWith(status: ProfileStatus.failure));
    }
  }

  Future<void> _onUploadPhoto(UploadPhoto event, Emitter<ProfileState> emit) async {
    // Dosya oluştur
    final file = File(event.filePath);
    final fileName = file.path.split('/').last;

    // MultipartFile oluştur
    final multipartFile = await MultipartFile.fromFile(
      file.path,
      filename: fileName,
      contentType: MediaType("image", "png"), // Eğer "package:http_parser/http_parser.dart" eklenirse
    );

    // FormData hazırla
    final formData = FormData.fromMap({'file': multipartFile});

    await service.uploadPhoto(formData);
    add(FetchProfile()); // fotoğraf sonrası tekrar yükle
  }
}
