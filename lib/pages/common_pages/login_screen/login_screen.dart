// ignore_for_file: use_build_context_synchronously

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ring_link/blocs/common_blocs/loginBloc/bloc/login_bloc.dart';
import 'package:ring_link/main.dart';
import 'package:ring_link/routes/routes.dart';
import 'package:ring_link/utils/num_txt.dart';
import 'package:ring_link/widgets/components.dart';
import '../../../utils/enums.dart';
import '../../../utils/library.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();

  late LoginBloc loginBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginBloc = LoginBloc(getIt());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    loginBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.focusScope.unfocus();
      },
      child: BlocProvider(
        create: (context) => loginBloc,
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: screenPadding,
                child: Column(
                  children: [
                    (context.screenHeight * 0.03).heightBox,
                    appLogo(width: 100, height: 100),
                    (context.screenHeight * 0.03).heightBox,
                    Text(
                      "Welcome Back, Fighter!",
                      style: context.headlineLarge,
                      textAlign: textAlignCenter,
                    ),
                    (context.screenHeight * 0.03).heightBox,
                    Form(
                        key: formkey,
                        child: Column(
                          children: [
                            BlocBuilder<LoginBloc, LoginState>(
                              buildWhen: (previous, current) =>
                                  previous.email != current.email,
                              builder: (context, state) {
                                return CustomTextFormField(
                                  prefixIcon: Iconsax.sms,
                                  hintText: emailHint,
                                  onChanged: (value) {
                                    loginBloc.add(EmailChangedLogin(value));
                                  },
                                  fillColor: Colors.transparent,
                                  borderColor: AppColors.lightGrey,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: Validator.validateEmail,
                                );
                              },
                            ),
                            20.heightBox,
                            BlocProvider(
                              create: (context) => TextFieldCubit(),
                              child: BlocBuilder<LoginBloc, LoginState>(
                                buildWhen: (previous, current) =>
                                    previous.password != current.password,
                                builder: (context, state) {
                                  return CustomTextFormField(
                                    prefixIcon: Iconsax.lock,
                                    obscureText: true,
                                    hintText: passwordHint,
                                    onChanged: (value) {
                                      loginBloc
                                          .add(PasswordChangedLogin(value));
                                    },
                                    fillColor: Colors.transparent,
                                    borderColor: AppColors.lightGrey,
                                    keyboardType: TextInputType.visiblePassword,
                                    validator: Validator.validatePassword,
                                  );
                                },
                              ),
                            ),
                            5.heightBox,
                            Row(
                              mainAxisAlignment: mainAxisSpaceBetween,
                              children: [
                                Row(
                                  children: [
                                    BlocBuilder<LoginBloc, LoginState>(
                                      buildWhen: (previous, current) =>
                                          previous.rememberMe !=
                                          current.rememberMe,
                                      builder: (context, state) {
                                        return Checkbox(
                                          value: state.rememberMe,
                                          onChanged: (value) {
                                            loginBloc
                                                .add(RememberMeEvent(value!));
                                          },
                                          side: const BorderSide(
                                              color: Colors.white),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                          ),
                                          checkColor: Colors.black,
                                          activeColor: Colors.white,
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          visualDensity: VisualDensity.compact,
                                        );
                                      },
                                    ),
                                    Text(
                                      'Remember me',
                                      style: context.bodyMedium,
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text('Forgot Password?',
                                      style: context.bodyLarge!.copyWith(
                                          color: AppColors.primaryColor)),
                                ),
                              ],
                            ),
                            (context.screenHeight * 0.05).heightBox,
                            BlocListener<LoginBloc, LoginState>(
                              listenWhen: (previous, current) =>
                                  previous.apiStatus != current.apiStatus,
                              listener: (context, state) async {
                                if (state.apiStatus == ApiStatus.success) {
                                  context.pushReplacementNamed(
                                      AppRouteNames.navbar);
                                }
                                if (state.apiStatus == ApiStatus.error) {
                                  Utils.anotherFlushbar(
                                      context,
                                      state.message.toString(),
                                      AppColors.errorColor);
                                }
                              },
                              child: BlocBuilder<LoginBloc, LoginState>(
                                buildWhen: (previous, current) =>
                                    previous.apiStatus != current.apiStatus,
                                builder: (context, state) {
                                  return SizedBox(
                                    width: context.screenWidth * 0.9,
                                    height: context.screenHeight * 0.06,
                                    child: RoundButton(
                                      isLoading:
                                          state.apiStatus == ApiStatus.loading,
                                      text: "Log In",
                                      onPressed: () {
                                        if (formkey.currentState!.validate()) {
                                          context
                                              .read<LoginBloc>()
                                              .add(OnLoginUserEvent());
                                        }
                                      },
                                      fontsize: 18,
                                      backgroundColor: AppColors.buttonColor,
                                    ),
                                  );
                                },
                              ),
                            ),
                            20.heightBox,
                            GestureDetector(
                              onTap: () {
                                context.pushNamed(AppRouteNames.registeration);
                              },
                              child: RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: "Don’t have an account? ",
                                    style: context.bodyMedium),
                                TextSpan(
                                    text: "Sign up",
                                    style: context.bodyLarge!.copyWith(
                                        color: AppColors.primaryColor)),
                              ])),
                            ),
                            (context.screenHeight * 0.03).heightBox,
                            SizedBox(
                              width: context.screenWidth * 0.9,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: Colors.grey.shade700,
                                      thickness: 1,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: Text('Or Continue With',
                                        style: context.bodyMedium),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: Colors.grey.shade700,
                                      thickness: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            30.heightBox,
                            Row(
                              mainAxisAlignment: mainAxisCenter,
                              children: [
                                Container(
                                  padding: padding10,
                                  decoration: BoxDecoration(
                                      color: Color(0xff212429),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Center(
                                      child: Image.asset(
                                    fbimg,
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.fill,
                                  )),
                                ),
                                20.widthBox,
                                Container(
                                  padding: padding10,
                                  decoration: BoxDecoration(
                                      color: Color(0xff212429),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Center(
                                      child: Image.asset(
                                    googleimg,
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.fill,
                                  )),
                                ),
                                20.widthBox,
                                Container(
                                  padding: padding10,
                                  decoration: BoxDecoration(
                                      color: Color(0xff212429),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Center(
                                      child: Image.asset(
                                    ximg,
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.fill,
                                  )),
                                )
                              ],
                            )
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
