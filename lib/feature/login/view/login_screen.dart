import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../core/init/navigator/navigation_service.dart';
import '../../../product/route/route.dart';
import '../../../product/widget/custom_button.dart';
import '../../../product/widget/custom_textfield.dart';
import '../../../product/widget/social_icon_button.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: const LoginCard(),
          ),
        ),
      ),
    );
  }
}

class LoginCard extends StatelessWidget {
  const LoginCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state.status == LoginStatus.success) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            NavigationService.instance?.pushReplacementNamed(AppRoutes.home);
          });
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildWelcomeText(context),
            SizedBox(height: 1.h),
            _buildDescriptionText(context),
            SizedBox(height: 4.h),
            _buildEmailField(context),
            SizedBox(height: 2.h),
            _buildPasswordField(context),
            SizedBox(height: 2.h),
            _buildForgotPasswordText(context),
            SizedBox(height: 3.h),
            _buildLoginButtonOrLoading(context, state),
            _buildErrorText(context, state),
            SizedBox(height: 4.h),
            _buildSocialButtons(),
            SizedBox(height: 3.h),
            _buildRegisterText(context),
          ],
        );
      },
    );
  }

  Widget _buildWelcomeText(BuildContext context) {
    return Text(
      'login.welcome'.tr(),
      style: Theme.of(
        context,
      ).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.bold, fontSize: 21.sp),
    );
  }

  Widget _buildDescriptionText(BuildContext context) {
    return Text(
      'login.description'.tr(),
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7), fontSize: 16.sp),
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return CustomTextField(
      hintText: 'login.email'.tr(),
      icon: Icons.email_outlined,
      onChanged: (value) => context.read<LoginBloc>().add(EmailChanged(value)),
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    final isObscure = context.select((LoginBloc bloc) => bloc.state.isPasswordObscure);

    return CustomTextField(
      hintText: 'login.password'.tr(),
      icon: Icons.lock_outline,
      isObscure: isObscure,
      suffixIcon: IconButton(
        icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility, color: Theme.of(context).iconTheme.color?.withOpacity(0.7)),
        onPressed: () => context.read<LoginBloc>().add(TogglePasswordVisibility()),
      ),
      onChanged: (value) => context.read<LoginBloc>().add(PasswordChanged(value)),
    );
  }

  Widget _buildForgotPasswordText(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'login.forgot_password'.tr(),
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onPrimary, fontSize: 15.sp, decoration: TextDecoration.underline),
      ),
    );
  }

  Widget _buildLoginButtonOrLoading(BuildContext context, LoginState state) {
    if (state.status == LoginStatus.submitting) {
      return CircularProgressIndicator(color: Theme.of(context).colorScheme.primary);
    } else {
      return CustomButton(onPressed: () => context.read<LoginBloc>().add(LoginSubmitted()), title: 'login.login_button'.tr());
    }
  }

  Widget _buildErrorText(BuildContext context, LoginState state) {
    if (state.status == LoginStatus.failure && state.error != null) {
      return Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Text(
          state.error!,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.primary, fontSize: 14.sp),
        ),
      );
    }
    return const SizedBox();
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

  Widget _buildRegisterText(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigationService.instance?.pushReplacementNamed(AppRoutes.register);
      },
      child: RichText(
        text: TextSpan(
          text: 'login.no_account'.tr(),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onPrimary, fontSize: 15.sp),
          children: [
            TextSpan(
              text: " ${'login.register'.tr()}",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
