// import 'package:auction_app/app/modules/modules.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final double height;

//   const CustomAppBar({super.key, this.height = kToolbarHeight});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         AppBar(
//           surfaceTintColor: Colors.transparent,
//           backgroundColor: Colors.transparent,
//           leading: Padding(
//             padding:
//                 const EdgeInsets.only(left: 18, top: 12, bottom: 12, right: 4),
//             child: Icon(
//               Iconsax.menu_1,
//               color: Vx.white,
//             ).box.roundedSM.color(AppColors.primaryColor).make(),
//           ),
//           centerTitle: false,
//           title: appLogo(
//             width: context.width * 0.3,
//             height: context.height * 0.07,
//           ).box.height(context.height * 0.07).width(context.width * 0.3).make(),
//           actions: [
//             const Icon(Iconsax.notification),
//             const SizedBox(width: 20),
//             const Icon(Iconsax.setting_2).box.make().onTap(() {
//               Get.toNamed(Routes.SETTINGS);
//             }),
//             const SizedBox(width: 10),
//           ],
//         ),
//         Divider(
//             height: 1,
//             thickness: 1,
//             color: Colors.grey[300]), 
//       ],
//     );
//   }

//   @override
//   Size get preferredSize => Size.fromHeight(height + 1);
// }
