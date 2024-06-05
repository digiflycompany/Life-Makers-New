// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:life_makers/core/utils/app-color.dart';
// import 'package:life_makers/features/authentication/data/models/area_model.dart';
//
// class CityAndCenterFields extends StatelessWidget {
//   const CityAndCenterFields({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Padding(
//           padding: EdgeInsets.only(top: 14.h),
//           child: Container(
//             height: 50,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10.r),
//               border: Border.all(color: Colors.black26),
//             ),
//             child: Center(
//               child: DropdownButton2<String>(
//                 underline: const SizedBox.shrink(),
//                 alignment: Alignment.centerRight,
//                 items: signUpCubit.areasList
//                     .map((Areas area) => DropdownMenuItem<String>(
//                   value: area.name ??
//                       "", // Assuming city.name is a String
//                   child: Align(
//                     alignment: Alignment.centerRight,
//                     child: Text(
//                       area.name ?? "",
//                       textDirection: TextDirection.rtl,
//                       maxLines: 2,
//                       style: TextStyle(
//                           fontFamily: 'Alexandria'),
//                     ),
//                   ),
//                 ))
//                     .toSet()
//                     .toList(),
//                 onChanged: (String? areaName) {
//                   // Update the selected city name
//                   signUpCubit.selectedAreaName = areaName;
//
//                   // Find the corresponding city object based on the selected city name
//                   final selectedArea =
//                   signUpCubit.areasList.firstWhere(
//                         (area) => area.name == areaName,
//                     orElse: () => signUpCubit.areasList
//                         .first, // Default to the first city
//                   );
//
//                   // Update your state or perform actions with the selected city
//                   signUpCubit.areaDropdownController.text =
//                       selectedArea.name ?? "";
//                   signUpCubit.fetchAreaData();
//                 },
//                 isExpanded: true,
//                 hint: Text(
//                   signUpCubit.selectedAreaName ?? 'المركز',
//                   style: TextStyle(
//                       color: AppColors.smallTextColor,
//                       fontSize: 11.sp,
//                       fontWeight: FontWeight.w700),
//                 ), // Set the selected value
//                 style: TextStyle(
//                   fontSize: 12,
//                   height: 1.0,
//                   color: Colors.black,
//                 ),
//                 buttonStyleData: ButtonStyleData(
//                   //padding: EdgeInsets.only(right: 10.w),
//                   height: 40,
//                   width: 160.w,
//                 ),
//                 dropdownStyleData: DropdownStyleData(
//                   maxHeight: 200,
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(8.0),
//                       border:
//                       Border.all(color: Colors.transparent)),
//                 ),
//                 menuItemStyleData: const MenuItemStyleData(
//                   height: 40,
//                 ),
//                 dropdownSearchData: DropdownSearchData(
//                   searchController: signUpCubit.textEditingController2,
//                   searchInnerWidgetHeight: 50,
//                   searchInnerWidget: Container(
//                     height: 50,
//                     padding: const EdgeInsets.only(
//                       top: 8,
//                       bottom: 4,
//                       right: 8,
//                       left: 8,
//                     ),
//                     child: TextFormField(
//                       expands: true,
//                       maxLines: null,
//                       controller: signUpCubit.textEditingController2,
//                       decoration: InputDecoration(
//                         isDense: true,
//                         contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 10,
//                           vertical: 8,
//                         ),
//                         hintTextDirection: TextDirection.rtl,
//                         hintText: 'ابحث عن مركز....',
//                         hintStyle: const TextStyle(fontSize: 12),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                     ),
//                   ),
//                   searchMatchFn: (item, searchValue) {
//                     final myItem = signUpCubit.areasList.firstWhere(
//                             (element) => element.name == item.value);
//                     return myItem.name!.contains(searchValue) ||
//                         item.value.toString().contains(searchValue);
//                   },
//                 ),
//                 onMenuStateChange: (isOpen) {
//                   if (!isOpen) {
//                     signUpCubit.textEditingController2.clear();
//                   }
//                 },
//               ),
//             ),
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.only(top: 14.h, right: 7.w),
//           child: Container(
//             height: 50,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10.r),
//               border: Border.all(color: Colors.black26),
//             ),
//             child: Center(
//               child: DropdownButton2<String>(
//                 underline: SizedBox.shrink(),
//                 isExpanded: true,
//                 items: signUpCubit.citiesList
//                     .map((Cities city) => DropdownMenuItem<String>(
//                   value: city.name ??
//                       "", // Assuming city.name is a String
//                   child: Align(
//                     alignment: Alignment.centerRight,
//                     child: Text(
//                       city.name ?? "",
//                       textDirection: TextDirection.rtl,
//                       maxLines:
//                       2, // Set text direction to RTL
//                     ),
//                   ),
//                 ))
//                     .toList(),
//                 onChanged: (String? cityName) {
//                   signUpCubit.selectedCityName = cityName;
//                   signUpCubit.selectedAreaName = null;
//                   setState(() {});
//                   // Find the corresponding city object based on the selected city name
//                   final selectedCity =
//                   signUpCubit.citiesList.firstWhere(
//                         (city) => city.name == cityName,
//                     orElse: () => signUpCubit.citiesList
//                         .first, // Default to the first city
//                   );
//                   signUpCubit.cityDropdownController.text =
//                       selectedCity.name ?? "";
//                   signUpCubit.cityId =
//                       selectedCity.id?.toInt() ?? 0;
//                   signUpCubit.fetchAreaData();
//                 },
//                 hint: Align(
//                   alignment: Alignment.centerRight,
//                   child: Text(
//                     signUpCubit.selectedCityName ?? 'المحافظة',
//                     style: TextStyle(
//                         color: AppColors.smallTextColor,
//                         fontFamily: FontFamilies.alexandria,
//                         fontSize: 11,
//                         fontWeight: FontWeight.w700),
//                   ),
//                 ), // Set the selected value
//                 style: TextStyle(
//                   fontFamily: FontFamilies.alexandria,
//                   fontSize: 12,
//                   color: Colors.black,
//                 ),
//                 buttonStyleData: ButtonStyleData(
//                   height: 40,
//                   width: 160.w,
//                 ),
//
//                 dropdownStyleData: DropdownStyleData(
//                   maxHeight: 200,
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(8.0),
//                       border:
//                       Border.all(color: Colors.transparent)),
//                 ),
//                 menuItemStyleData: const MenuItemStyleData(
//                   height: 40,
//                 ),
//                 dropdownSearchData: DropdownSearchData(
//                   searchController: signUpCubit.textEditingController,
//                   searchInnerWidgetHeight: 50,
//                   searchInnerWidget: Container(
//                     height: 50,
//                     padding: const EdgeInsets.only(
//                       top: 8,
//                       bottom: 4,
//                       right: 8,
//                       left: 8,
//                     ),
//                     child: TextFormField(
//                       expands: true,
//                       maxLines: null,
//                       controller: signUpCubit.textEditingController,
//                       decoration: InputDecoration(
//                         isDense: true,
//                         contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 10,
//                           vertical: 8,
//                         ),
//                         hintTextDirection: TextDirection.rtl,
//                         hintText: 'ابحث عن محافظة....',
//                         hintStyle: const TextStyle(fontSize: 12),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                     ),
//                   ),
//                   searchMatchFn: (item, searchValue) {
//                     final myItem = signUpCubit.citiesList
//                         .firstWhere((element) =>
//                     element.name == item.value);
//                     return myItem.name!.contains(searchValue) ||
//                         item.value.toString().contains(searchValue);
//                   },
//                 ),
//                 onMenuStateChange: (isOpen) {
//                   if (!isOpen) {
//                     signUpCubit.textEditingController.clear();
//                   }
//                 },
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/widgets/spacer.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_states.dart';
import 'package:life_makers/features/authentication/data/models/area_model.dart';
import 'package:life_makers/features/authentication/data/models/city_model.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/custom_drop_down.dart';

class CityAndCenterFields extends StatelessWidget {
  const CityAndCenterFields({super.key, this.items, this.onChangeFunction});

  final List<DropdownMenuItem<City>>? items;
  final Function(String? cityName)? onChangeFunction;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (BuildContext context, SignUpState state) {},
      builder: (BuildContext context, SignUpState state) {
        final signUpCubit = SignUpCubit.get(context);
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomDropDown(
                hint: "المحافظة",
                validationMessage: "من فضلك اختر المحافظة",
                items: signUpCubit.citiesList
                    .map((City city) => DropdownMenuItem<City>(
                          value: city,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: FittedBox(
                              child: Text(
                                city.name ?? "",
                                style: TextStyle(fontSize: 10.sp),
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                          ),
                        ))
                    .toList(),
                onChange: (cityName) {
                  signUpCubit.selectedCity = cityName;
                  signUpCubit.fetchAreaData();
                }),
            HorizontalSpace(10.w),
            CustomDropDown(
                hint: "مركز",
                validationMessage: "من فضلك اختر المركز",
                items: signUpCubit.areasList
                    .map((Areas area) => DropdownMenuItem<Areas>(
                          value: area,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: FittedBox(
                              child: Text(
                                area.name ?? "",
                                style: TextStyle(fontSize: 10.sp),
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                          ),
                        ))
                    .toList(),
                onChange: (cityName) {
                  signUpCubit.selectedCity = cityName;
                  signUpCubit.fetchAreaData();
                }),
          ],
        );
      },
    );
  }
}
