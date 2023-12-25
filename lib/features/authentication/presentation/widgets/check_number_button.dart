// import 'package:flutter/material.dart';
// import 'package:life_makers/core/utils/extensions.dart';
// import 'package:page_transition/page_transition.dart';
// import '../../../../core/utils/app-color.dart';
// import '../../../../core/utils/app-string.dart';
// import '../../../../core/utils/app_fonts.dart';
// import '../pages/otp_screen.dart';
//
// class CheckNumberButton extends StatelessWidget {
//   const CheckNumberButton({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: (){
//         Navigator.push(context, PageTransition(
//             type: PageTransitionType.fade,
//             duration: const Duration(milliseconds: 400),
//             child:OtpScreen()
//         ),
//         );
//       },
//       child: Align(
//           alignment: AlignmentDirectional.centerEnd,
//           child: Container(
//             width: 165.w,
//             height: 56.h,
//             decoration: BoxDecoration(
//                 color: AppColors.orangeBorderColor,
//                 borderRadius: BorderRadius.circular(5.r)
//             ),
//             child: Center(
//               child: Text(
//                 AppStrings.checkNumber,
//                 textDirection: TextDirection.rtl,
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontFamily: FontFamilies.alexandria,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 11.5
//                 ),
//               ),
//             ),
//           )),
//     );
//   }
// }
