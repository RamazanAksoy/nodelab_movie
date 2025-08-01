import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../core/init/navigator/navigation_service.dart';
import '../../../product/route/route.dart';
import '../../../product/widget/custom_button.dart';
import '../../../product/widget/custom_textfield.dart';
import '../../../product/widget/social_icon_button.dart';
import '../bloc/register_bloc.dart';
import '../bloc/register_event.dart';
import '../bloc/register_state.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterBloc(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: const RegisterCard(),
          ),
        ),
      ),
    );
  }
}

class RegisterCard extends StatelessWidget {
  const RegisterCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        if (state.status == RegisterStatus.success) {
          Future.microtask(() => _showSuccessDialog(context, colorScheme, textTheme));
        }

        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildWelcomeText(textTheme, colorScheme),
              SizedBox(height: 1.h),
              _buildDescriptionText(textTheme, colorScheme),
              SizedBox(height: 4.h),
              _buildNameField(context),
              SizedBox(height: 2.h),
              _buildEmailField(context),
              SizedBox(height: 2.h),
              _buildPasswordField(context, state.isPasswordObscure ?? false),
              SizedBox(height: 2.h),
              _buildConfirmPasswordField(context, state.isPasswordObscure ?? false),
              SizedBox(height: 3.h),
              _buildSubmitButtonOrLoading(context, state),
              _buildErrorText(state, colorScheme),
              SizedBox(height: 4.h),
              _buildSocialButtons(),
              SizedBox(height: 3.h),
              _buildLoginRedirectText(context, textTheme, colorScheme),
            ],
          ),
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context, ColorScheme colorScheme, TextTheme textTheme) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: colorScheme.background,
        title: Text('register.success_title'.tr(), style: textTheme.titleLarge?.copyWith(color: colorScheme.onBackground)),
        content: Text('register.success_content'.tr(), style: textTheme.bodyMedium?.copyWith(color: colorScheme.onBackground.withOpacity(0.7))),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              NavigationService.instance?.pushReplacementNamed(AppRoutes.login);
            },
            child: Text('register.success_button'.tr(), style: TextStyle(color: colorScheme.primary)),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeText(TextTheme textTheme, ColorScheme colorScheme) {
    return Text(
      'register.welcome'.tr(),
      style: textTheme.titleLarge?.copyWith(color: colorScheme.onPrimary, fontWeight: FontWeight.bold, fontSize: 21.sp),
    );
  }

  Widget _buildDescriptionText(TextTheme textTheme, ColorScheme colorScheme) {
    return Text(
      'register.description'.tr(),
      textAlign: TextAlign.center,
      style: textTheme.bodyMedium?.copyWith(color: colorScheme.onBackground.withOpacity(0.7), fontSize: 16.sp),
    );
  }

  Widget _buildNameField(BuildContext context) {
    return CustomTextField(
      hintText: 'register.name'.tr(),
      icon: Icons.person_outline,
      onChanged: (value) => context.read<RegisterBloc>().add(NameChanged(value)),
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return CustomTextField(
      hintText: 'register.email'.tr(),
      icon: Icons.email_outlined,
      onChanged: (value) => context.read<RegisterBloc>().add(EmailChanged(value)),
    );
  }

  Widget _buildPasswordField(BuildContext context, bool isObscure) {
    return CustomTextField(
      hintText: 'register.password'.tr(),
      icon: Icons.lock_outline,
      isObscure: isObscure,
      suffixIcon: IconButton(
        icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility, color: Theme.of(context).iconTheme.color?.withOpacity(0.7)),
        onPressed: () => context.read<RegisterBloc>().add(TogglePasswordVisibility()),
      ),
      onChanged: (value) => context.read<RegisterBloc>().add(PasswordChanged(value)),
    );
  }

  Widget _buildConfirmPasswordField(BuildContext context, bool isObscure) {
    return CustomTextField(
      hintText: 'register.confirm_password'.tr(),
      icon: Icons.lock_outline,
      isObscure: isObscure,
      onChanged: (value) => context.read<RegisterBloc>().add(ConfirmPasswordChanged(value)),
    );
  }

  Widget _buildSubmitButtonOrLoading(BuildContext context, RegisterState state) {
    if (state.status == RegisterStatus.submitting) {
      return CircularProgressIndicator(color: Theme.of(context).colorScheme.primary);
    }
    return CustomButton(onPressed: () => context.read<RegisterBloc>().add(RegisterSubmitted()), title: 'register.register_button'.tr());
  }

  Widget _buildErrorText(RegisterState state, ColorScheme colorScheme) {
    if (state.status == RegisterStatus.failure && state.error != null) {
      return Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Text(
          state.error!,
          style: TextStyle(color: colorScheme.primary, fontSize: 14.sp),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildSocialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        SocialIconButton(icon: FontAwesomeIcons.google),
        SizedBox(width: 16),
        SocialIconButton(icon: FontAwesomeIcons.apple),
        SizedBox(width: 16),
        SocialIconButton(icon: FontAwesomeIcons.facebookF),
      ],
    );
  }

  Widget _buildLoginRedirectText(BuildContext context, TextTheme textTheme, ColorScheme colorScheme) {
    return GestureDetector(
      onTap: () {
        NavigationService.instance?.pushReplacementNamed(AppRoutes.login);
      },
      child: RichText(
        text: TextSpan(
          text: 'register.have_account'.tr(),
          style: textTheme.bodyMedium?.copyWith(color: colorScheme.onPrimary, fontSize: 15.sp),
          children: [
            TextSpan(
              text: " ${'register.login'.tr()}",
              style: textTheme.bodyMedium?.copyWith(color: colorScheme.onPrimary, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
