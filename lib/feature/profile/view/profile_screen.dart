import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../core/constants/enums/preferences_types.dart';
import '../../../core/init/cache/locale_manager.dart';
import '../../../core/init/language/language_manager.dart';
import '../../../core/init/theme/theme_service.dart';
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
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        backgroundColor: colorScheme.background, // önceki Colors.black yerine tema
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state.status == ProfileStatus.loading) {
              return Center(child: CircularProgressIndicator(color: colorScheme.primary));
            }

            if (state.status == ProfileStatus.failure || state.user == null) {
              return Center(
                child: Text("profile.loading_error".tr(), style: textTheme.bodyMedium?.copyWith(color: colorScheme.onBackground)),
              );
            }

            return _buildProfileContent(context, state, colorScheme, textTheme);
          },
        ),
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, ProfileState state, ColorScheme colorScheme, TextTheme textTheme) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopBar(context, colorScheme, textTheme),
          SizedBox(height: 4.h),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildProfileInfo(context, state.user!, colorScheme, textTheme),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [_buildFavoritesTitle(textTheme, colorScheme), _buildThemeSwitch(context, colorScheme)],
                  ),
                  SizedBox(height: 1.5.h),
                  _buildFavoritesGrid(state.favorites, colorScheme, textTheme),
                  SizedBox(height: 3.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, ColorScheme colorScheme, TextTheme textTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildBackIcon(colorScheme),
        _buildTitle(textTheme, colorScheme),
        Row(
          children: [
            _buildLimitedOfferButton(context, colorScheme, textTheme),
            SizedBox(width: 2.w),
            _buildLanguageButton(context, colorScheme),
          ],
        ),
      ],
    );
  }

  Widget _buildLanguageButton(BuildContext context, ColorScheme colorScheme) {
    return PopupMenuButton<Locale>(
      icon: Icon(Icons.language, color: colorScheme.onPrimary),
      color: colorScheme.background,
      onSelected: (Locale locale) {
        context.setLocale(locale);
        LocaleManager.instance.setStringValue(PreferencesTypes.language, locale.languageCode);
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: LanguageManager.instance?.trLocale,
          child: Text('Türkçe', style: TextStyle(color: colorScheme.onPrimary)),
        ),
        PopupMenuItem(
          value: LanguageManager.instance?.enLocale,
          child: Text('English', style: TextStyle(color: colorScheme.onPrimary)),
        ),
      ],
    );
  }

  Widget _buildBackIcon(ColorScheme colorScheme) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: colorScheme.onPrimary.withOpacity(0.6), width: 1),
      ),
      padding: EdgeInsets.all(2.w),
      child: Icon(Icons.arrow_back, color: colorScheme.onPrimary.withOpacity(0.7), size: 20),
    );
  }

  Widget _buildTitle(TextTheme textTheme, ColorScheme colorScheme) {
    return Text(
      "profile.title".tr(),
      style: textTheme.titleMedium?.copyWith(color: colorScheme.onPrimary, fontWeight: FontWeight.bold, fontSize: 17.sp),
    );
  }

  Widget _buildLimitedOfferButton(BuildContext context, ColorScheme colorScheme, TextTheme textTheme) {
    return GestureDetector(
      onTap: () => _showJetonBottomSheet(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        decoration: BoxDecoration(color: colorScheme.primary, borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Icon(Icons.local_offer, color: colorScheme.onPrimary, size: 16),
            SizedBox(width: 1.w),
            Text(
              "profile.limited_offer".tr(),
              style: textTheme.bodyMedium?.copyWith(color: colorScheme.onPrimary, fontWeight: FontWeight.bold, fontSize: 14.sp),
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
              decoration: BoxDecoration(
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

  Widget _buildProfileInfo(BuildContext context, UserResponse user, ColorScheme colorScheme, TextTheme textTheme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 1.5.h),
          child: CircleAvatar(
            backgroundImage: (user.data?.photoUrl?.isEmpty ?? true || user.data == null) ? null : NetworkImage(user.data!.photoUrl!),
            radius: 32,
          ),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNameAndPhotoButton(context, user, colorScheme, textTheme),
              SizedBox(height: 1.h),
              Text(
                "${"profile.id_label".tr()}: ${user.data?.id}",
                style: textTheme.bodyMedium?.copyWith(color: colorScheme.onPrimary.withOpacity(0.7), fontSize: 15.sp),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNameAndPhotoButton(BuildContext context, UserResponse user, ColorScheme colorScheme, TextTheme textTheme) {
    return Row(
      children: [
        Expanded(
          child: Text(
            user.data?.name ?? "",
            style: textTheme.titleMedium?.copyWith(color: colorScheme.onPrimary, fontSize: 18.sp, fontWeight: FontWeight.bold),
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
            backgroundColor: colorScheme.primary,
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Text(
            "profile.add_photo".tr(),
            style: textTheme.bodyMedium?.copyWith(color: colorScheme.onPrimary, fontWeight: FontWeight.bold, fontSize: 14.sp),
          ),
        ),
      ],
    );
  }

  Widget _buildThemeSwitch(BuildContext context, ColorScheme colorScheme) {
    final themeService = Provider.of<ThemeService>(context);

    return Switch(value: themeService.isDarkMode(), activeColor: colorScheme.primary, onChanged: (_) => themeService.toggleTheme());
  }

  Widget _buildFavoritesTitle(TextTheme textTheme, ColorScheme colorScheme) {
    return Text(
      "profile.favorites_title".tr(),
      style: textTheme.titleMedium?.copyWith(color: colorScheme.onPrimary, fontWeight: FontWeight.bold, fontSize: 17.sp),
    );
  }

  Widget _buildFavoritesGrid(List<Movie> favorites, ColorScheme colorScheme, TextTheme textTheme) {
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
              style: textTheme.bodyMedium?.copyWith(color: colorScheme.onPrimary, fontWeight: FontWeight.bold, fontSize: 15.sp),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              movie.director ?? "",
              style: textTheme.bodySmall?.copyWith(color: colorScheme.onPrimary.withOpacity(0.54), fontSize: 13.sp),
            ),
          ],
        );
      },
    );
  }
}
