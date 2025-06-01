import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ring_link/blocs/common_blocs/choose_role_Bloc/bloc/chooserole_bloc.dart';
import 'package:ring_link/main.dart';
import 'package:ring_link/routes/routes.dart';
import 'package:ring_link/services/storage.dart';
import 'package:ring_link/utils/library.dart';
import 'package:ring_link/utils/num_txt.dart';
import 'package:ring_link/widgets/components.dart';

class ChooseRoleScreen extends StatefulWidget {
  const ChooseRoleScreen({super.key});

  @override
  State<ChooseRoleScreen> createState() => _ChooseRoleScreenState();
}

class _ChooseRoleScreenState extends State<ChooseRoleScreen> {
  late ChooseroleBloc chooseroleBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chooseroleBloc = ChooseroleBloc(getIt());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => chooseroleBloc,
      child: Scaffold(
        body: Column(
          children: [
            40.heightBox,
            CustomAppBar(title: "Choose Your Role "),
            Padding(
              padding: symmetricHorizontal20,
              child: Column(
                crossAxisAlignment: crossAxisStart,
                children: [
                  Text(
                    "Choose Your Path",
                    style: context.bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  10.heightBox,
                  Text(
                    "Are you a trainer looking to grow your client base or an artist seeking top-tier coaching?",
                    style: context.bodySmall!
                        .copyWith(color: AppColors.textColorSecondary),
                  ),
                  30.heightBox,
                  Row(
                    children: [
                      BlocBuilder<ChooseroleBloc, ChooseroleState>(
                        buildWhen: (previous, current) =>
                            previous.chooseRole != current.chooseRole,
                        builder: (context, state) {
                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                chooseroleBloc.add(ChooseRoleChanged(
                                    chooseRole: UserType.artist));
                              },
                              child: Container(
                                padding: padding12,
                                decoration: BoxDecoration(
                                    color: Color(0xff1C1F23),
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color:
                                            state.chooseRole == UserType.artist
                                                ? AppColors.buttonColor
                                                : Colors.transparent)),
                                child: Column(
                                  crossAxisAlignment: crossAxisStart,
                                  children: [
                                    Container(
                                      padding: padding5,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: AppColors.lightGrey)),
                                      child: Image.asset(
                                        "assets/icons/artist.png",
                                        width: 30,
                                        height: 30,
                                      ),
                                    ),
                                    10.heightBox,
                                    Text(
                                      "MMA Artist",
                                      style: context.bodyMedium,
                                    ),
                                    Text(
                                      "Find expert trainers, sparring partners, and training spaces",
                                      style: context.bodySmall!.copyWith(
                                          fontSize: 12,
                                          color: AppColors.lightGrey),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      10.widthBox,
                      BlocBuilder<ChooseroleBloc, ChooseroleState>(
                        buildWhen: (previous, current) =>
                            previous.chooseRole != current.chooseRole,
                        builder: (context, state) {
                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                chooseroleBloc.add(ChooseRoleChanged(
                                    chooseRole: UserType.trainer));
                              },
                              child: Container(
                                padding: padding12,
                                decoration: BoxDecoration(
                                    color: Color(0xff1C1F23),
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color:
                                            state.chooseRole == UserType.trainer
                                                ? AppColors.buttonColor
                                                : Colors.transparent)),
                                child: Column(
                                  crossAxisAlignment: crossAxisStart,
                                  children: [
                                    Container(
                                      padding: padding5,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: AppColors.lightGrey)),
                                      child: Image.asset(
                                        "assets/icons/trainer.png",
                                        width: 30,
                                        height: 30,
                                      ),
                                    ),
                                    10.heightBox,
                                    Text(
                                      "MMA Trainer",
                                      style: context.bodyMedium,
                                    ),
                                    5.heightBox,
                                    Text(
                                      "Build your client base and showcase your expertise",
                                      style: context.bodySmall!.copyWith(
                                          fontSize: 12,
                                          color: AppColors.lightGrey),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
            Spacer(),
            BlocBuilder<ChooseroleBloc, ChooseroleState>(
              buildWhen: (previous, current) =>
                  previous.chooseRole != current.chooseRole,
              builder: (context, state) {
                return SizedBox(
                  width: context.screenWidth * 0.9,
                  height: context.screenHeight * 0.06,
                  child: RoundButton(
                    text: "Continue",
                    onPressed: () async {
                      await storage.setValues(
                          StorageKeys.userType, state.chooseRole.name);
                      await storage.setValues(
                          StorageKeys.chooseRoleDone, true.toString());

                      context.pushNamed(AppRouteNames.login);
                    },
                    fontsize: 16,
                    backgroundColor: AppColors.buttonColor,
                  ),
                );
              },
            ),
            20.heightBox,
          ],
        ),
      ),
    );
  }
}
