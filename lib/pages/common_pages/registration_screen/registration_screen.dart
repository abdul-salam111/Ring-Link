import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ring_link/blocs/common_blocs/registration_bloc/bloc/registration_bloc.dart';
import 'package:ring_link/main.dart';
import 'package:ring_link/routes/app_route_names.dart';
import 'package:ring_link/utils/enums.dart';
import 'package:ring_link/utils/num_txt.dart';
import 'package:ring_link/widgets/components.dart';

import '../../../utils/library.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final formkey = GlobalKey<FormState>();
  late RegistrationBloc artistRegistrationBloc;
  @override
  void initState() {
    super.initState();
    artistRegistrationBloc = RegistrationBloc(getIt());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.focusScope.unfocus();
      },
      child: BlocProvider(
        create: (context) => artistRegistrationBloc,
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
                      "Join RingLink",
                      style: context.headlineLarge,
                      textAlign: textAlignCenter,
                    ),
                    (context.screenHeight * 0.03).heightBox,
                    Form(
                        key: formkey,
                        child: Column(
                          children: [
                            BlocBuilder<RegistrationBloc, RegistrationState>(
                              buildWhen: (previous, current) =>
                                  previous.username != current.username,
                              builder: (context, state) {
                                return CustomTextFormField(
                                  prefixIcon: Iconsax.user,
                                  hintText: nameHint,
                                  onChanged: (value) {
                                    context.read<RegistrationBloc>().add(
                                          UsernameChanged(value),
                                        );
                                  },
                                  fillColor: Colors.transparent,
                                  borderColor: AppColors.lightGrey,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: Validator.validateName,
                                );
                              },
                            ),
                            20.heightBox,
                            BlocBuilder<RegistrationBloc, RegistrationState>(
                              buildWhen: (previous, current) =>
                                  previous.email != current.email,
                              builder: (context, state) {
                                return CustomTextFormField(
                                  prefixIcon: Iconsax.sms,
                                  hintText: emailHint,
                                  onChanged: (value) {
                                    context.read<RegistrationBloc>().add(
                                          EmailChanged(value),
                                        );
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
                              child: BlocBuilder<RegistrationBloc,
                                  RegistrationState>(
                                buildWhen: (previous, current) =>
                                    previous.password != current.password,
                                builder: (context, state) {
                                  return CustomTextFormField(
                                    prefixIcon: Iconsax.lock,
                                    obscureText: true,
                                    hintText: passwordHint,
                                    onChanged: (value) {
                                      context.read<RegistrationBloc>().add(
                                            PasswordChanged(value),
                                          );
                                    },
                                    fillColor: Colors.transparent,
                                    borderColor: AppColors.lightGrey,
                                    keyboardType: TextInputType.visiblePassword,
                                    validator: Validator.validatePassword,
                                  );
                                },
                              ),
                            ),
                            20.heightBox,
                            BlocProvider(
                              create: (context) => TextFieldCubit(),
                              child: BlocBuilder<RegistrationBloc,
                                  RegistrationState>(
                                buildWhen: (previous, current) =>
                                    previous.confirmPassword !=
                                    current.confirmPassword,
                                builder: (context, state) {
                                  return CustomTextFormField(
                                    prefixIcon: Iconsax.lock,
                                    obscureText: true,
                                    hintText: "Enter your confirm password",
                                    onChanged: (value) {
                                      context.read<RegistrationBloc>().add(
                                            ConfirmPasswordChanged(value),
                                          );
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    BlocBuilder<RegistrationBloc,
                                        RegistrationState>(
                                      buildWhen: (previous, current) =>
                                          previous.termsAndConditionsAgreed !=
                                          current.termsAndConditionsAgreed,
                                      builder: (context, state) {
                                        return Checkbox(
                                          value: state.termsAndConditionsAgreed,
                                          onChanged: (value) {
                                            artistRegistrationBloc.add(
                                                TermsAndConditionsAgreed(
                                                    value!));
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
                                      'I agree to the Terms & Conditions',
                                      style: context.bodyMedium,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            (context.screenHeight * 0.05).heightBox,
                            BlocListener<RegistrationBloc, RegistrationState>(
                              listenWhen: (previous, current) =>
                                  previous.apiStatus != current.apiStatus,
                              listener: (context, state) {
                                if (state.apiStatus == ApiStatus.success) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CustomScanDialog(
                                          iconBackgroundColor:
                                              AppColors.secondaryColor,
                                          continueButtonText: "Verify",
                                          isOneButton: true,
                                          titleColor: AppColors.primaryColor,
                                          title: "Verify Email!",
                                          icon: Iconsax.send_2,
                                          onContinue: () {
                                            openGmail();
                                            context.pop();
                                            context.pop();
                                          },
                                          description:
                                              'Please check your email for verification',
                                          onCancel: () {
                                            context.pop();
                                          },
                                        );
                                      });
                                }
                                if (state.apiStatus == ApiStatus.error) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CustomScanDialog(
                                          iconBackgroundColor:
                                              AppColors.errorColor,
                                          continueButtonText: "Retry",
                                          isOneButton: true,
                                          titleColor: AppColors.errorColor,
                                          title: "Registration Failed!",
                                          icon: Icons.close,
                                          onContinue: () {
                                            context.pop();
                                          },
                                          description: state.message,
                                          onCancel: () {
                                            context.pop();
                                          },
                                        );
                                      });
                                }
                              },
                              child: BlocBuilder<RegistrationBloc,
                                  RegistrationState>(
                                buildWhen: (previous, current) =>
                                    previous.apiStatus != current.apiStatus,
                                builder: (context, state) {
                                  return SizedBox(
                                    width: context.screenWidth * 0.9,
                                    height: context.screenHeight * 0.06,
                                    child: RoundButton(
                                      isLoading:
                                          state.apiStatus == ApiStatus.loading
                                              ? true
                                              : false,
                                      text: "Create An Account",
                                      onPressed: () {
                                        if (formkey.currentState!.validate()) {
                                          context
                                              .read<RegistrationBloc>()
                                              .add(OnUserRegistrationEvent());
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
                                context.pushNamed(AppRouteNames.login);
                              },
                              child: RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: "Already, have an account? ",
                                    style: context.bodyMedium),
                                TextSpan(
                                    text: "Sign In",
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
