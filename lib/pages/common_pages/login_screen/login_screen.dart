import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:ring_link/utils/num_txt.dart';

import 'package:ring_link/widgets/components.dart';

import '../../../utils/library.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.focusScope.unfocus();
      },
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
                          CustomTextFormField(
                            prefixIcon: Iconsax.sms,
                            hintText: emailHint,
                            onChanged: (value) {},
                            fillColor: Colors.transparent,
                            borderColor: AppColors.lightGrey,
                            keyboardType: TextInputType.emailAddress,
                            validator: Validator.validateEmail,
                          ),
                          20.heightBox,
                          BlocProvider(
                            create: (context) => TextFieldCubit(),
                            child: CustomTextFormField(
                              prefixIcon: Iconsax.lock,
                              obscureText: true,
                              hintText: passwordHint,
                              onChanged: (value) {},
                              fillColor: Colors.transparent,
                              borderColor: AppColors.lightGrey,
                              keyboardType: TextInputType.visiblePassword,
                              validator: Validator.validatePassword,
                            ),
                          ),
                          5.heightBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: false,
                                    onChanged: (value) {},
                                    side: const BorderSide(color: Colors.white),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                    ),
                                    checkColor: Colors.black,
                                    activeColor: Colors.white,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    visualDensity: VisualDensity.compact,
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
                          SizedBox(
                            width: context.screenWidth * 0.9,
                            height: context.screenHeight * 0.06,
                            child: RoundButton(
                              text: "Log In",
                              onPressed: () {},
                              fontsize: 18,
                              backgroundColor: AppColors.buttonColor,
                            ),
                          ),
                          20.heightBox,
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "Don’t have an account? ",
                                style: context.bodyMedium),
                            TextSpan(
                                text: "Sign up",
                                style: context.bodyLarge!
                                    .copyWith(color: AppColors.primaryColor)),
                          ])),
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
    );
  }
}
