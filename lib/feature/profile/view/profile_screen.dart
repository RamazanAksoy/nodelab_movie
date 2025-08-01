import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../core/constants/enums/preferences_types.dart';
import '../../../core/init/cache/locale_manager.dart';
import '../../../core/init/language/language_manager.dart';
import '../../home/model/movie.dart';
import '../../login/model/user.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import 'jeton_bottomshet.dart';
import 'photo_upload_view.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state.status == ProfileStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == ProfileStatus.failure || state.user == null) {
              return Center(
                child: Text("profile.loading_error".tr(), style: const TextStyle(color: Colors.white)),
              );
            }

            return _buildProfileContent(context, state);
          },
        ),
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, ProfileState state) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopBar(context),
          SizedBox(height: 4.h),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildProfileInfo(context, state.user!),
                  SizedBox(height: 4.h),
                  _buildFavoritesTitle(),
                  SizedBox(height: 1.5.h),
                  _buildFavoritesGrid(state.favorites),
                  SizedBox(height: 3.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildBackIcon(),
        _buildTitle(),
        Row(
          children: [
            _buildLimitedOfferButton(context),
            SizedBox(width: 2.w),
            _buildLanguageButton(context),
          ],
        ),
      ],
    );
  }

  Widget _buildLanguageButton(BuildContext context) {
    return PopupMenuButton<Locale>(
      icon: const Icon(Icons.language, color: Colors.white),
      color: Colors.black,
      onSelected: (Locale locale) {
        context.setLocale(locale);
        LocaleManager.instance.setStringValue(PreferencesTypes.language, locale.languageCode);
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: LanguageManager.instance?.trLocale,
          child: Text('Türkçe', style: TextStyle(color: Colors.white)),
        ),
        PopupMenuItem(
          value: LanguageManager.instance?.enLocale,
          child: Text('English', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Widget _buildBackIcon() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white60, width: 1),
      ),
      padding: EdgeInsets.all(2.w),
      child: const Icon(Icons.arrow_back, color: Colors.white70, size: 20),
    );
  }

  Widget _buildTitle() {
    return Text(
      "profile.title".tr(),
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17.sp),
    );
  }

  Widget _buildLimitedOfferButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _showJetonBottomSheet(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        decoration: BoxDecoration(color: const Color(0xFFE50914), borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            const Icon(Icons.local_offer, color: Colors.white, size: 16),
            SizedBox(width: 1.w),
            Text(
              "profile.limited_offer".tr(),
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.sp),
            ),
          ],
        ),
      ),
    );
  }

  void _showJetonBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: Container(color: Colors.black.withOpacity(0.3)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.horizontal(left: Radius.circular(40), right: Radius.circular(40)),
              ),
              child: const JetonTeklifSheet(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfo(BuildContext context, UserResponse user) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 1.5.h),
          child: CircleAvatar(backgroundImage: NetworkImage(user.data?.photoUrl ?? "https://via.placeholder.com/150"), radius: 32),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNameAndPhotoButton(context, user),
              SizedBox(height: 1.h),
              Text(
                "${"profile.id_label".tr()}: ${user.data?.id}",
                style: TextStyle(color: Colors.white70, fontSize: 15.sp),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNameAndPhotoButton(BuildContext context, UserResponse user) {
    return Row(
      children: [
        Expanded(
          child: Text(
            user.data?.name ?? "",
            style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        SizedBox(width: 2.w),
        ElevatedButton(
          onPressed: () async {
            final result = await Navigator.push(context, MaterialPageRoute(builder: (_) => const PhotoUploadScreen()));
            if (result != null && context.mounted) {
              context.read<ProfileBloc>().add(UploadPhoto(result));
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE50914),
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Text(
            "profile.add_photo".tr(),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.sp),
          ),
        ),
      ],
    );
  }

  Widget _buildFavoritesTitle() {
    return Text(
      "profile.favorites_title".tr(),
      style: TextStyle(color: Colors.white, fontSize: 17.sp, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildFavoritesGrid(List<Movie> favorites) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: favorites.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 3.w, mainAxisSpacing: 1.h, childAspectRatio: 0.65),
      itemBuilder: (context, index) {
        final movie = favorites[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(movie.images?.first ?? "", height: 23.h, width: double.infinity, fit: BoxFit.cover),
            ),
            SizedBox(height: 1.h),
            Text(
              movie.title ?? "",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15.sp),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              movie.director ?? "",
              style: TextStyle(color: Colors.white54, fontSize: 13.sp),
            ),
          ],
        );
      },
    );
  }
}
