import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_states.dart';
import 'package:life_makers/features/authentication/data/models/user_model.dart';
import 'package:life_makers/features/authentication/presentation/pages/change_password_after_login.dart';
import 'package:life_makers/features/edit_account/cubit/edit_account_cubit.dart';
import 'package:life_makers/features/home_page/cubit/menu_page_cubit/menu_page_cubit.dart';
import 'package:life_makers/features/home_page/cubit/menu_page_cubit/menu_page_states.dart';
import 'package:life_makers/services/cubit/global_cubit_state.dart';
import 'package:life_makers/services/shared_preferences/preferences_helper.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../core/utils/app-assets.dart';
import '../../../core/utils/app-string.dart';
import '../../../core/utils/app_fonts.dart';
import '../../authentication/data/models/area_model.dart';
import '../../authentication/data/models/city_model.dart';
import '../../authentication/presentation/pages/login_screen.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({Key? key}) : super(key: key);

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  XFile? _image;

  String? selectedCityName;
  String? selectedAreaName;
  late SignUpCubit signUpCubit;
  UserModel userModel = PreferencesHelper.getUserModel!;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController JobController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController whatsappController = TextEditingController();

  final TextEditingController nationalIDController = TextEditingController();
  final TextEditingController previousExperienceController =
      TextEditingController();

  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController textEditingController2 = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    JobController.dispose();
    addressController.dispose();
    emailController.dispose();
    phoneController.dispose();
    whatsappController.dispose();
    nationalIDController.dispose();
    previousExperienceController.dispose();
  }

  @override
  void initState() {
    super.initState();
    selectedCityName = userModel.user?.governorate;
    selectedAreaName = userModel.user?.cityCenter;
    nameController.text = userModel.user?.name ?? '';
    userNameController.text = userModel.user?.username ?? '';
    emailController.text = userModel.user?.email ?? '';
    phoneController.text = userModel.user?.phone ?? '';
    whatsappController.text = userModel.user?.whatsappNumber ?? '';
    nationalIDController.text = userModel.user?.idCardNumber ?? '';
    addressController.text = userModel.user?.theAddress ?? '';
    previousExperienceController.text =
        userModel.user?.previousExperience ?? '';
    JobController.text = userModel.user?.theJob ?? '';

    signUpCubit = context.read<SignUpCubit>();
    signUpCubit.fetchCityData();
  }

  @override
  Widget build(BuildContext context) {
    final menuCubit = context.read<MenuCubit>();
    return BlocConsumer<MenuCubit, MenuState>(listener: (context, state) {
      if (state is DeleteAccountSuccess) {
        PreferencesHelper.logOut();
        Navigator.pushReplacement(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 400),
              child: LoginScreen(),
            ));
      } else if (state is DeleteAccountFailure) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.error),
          duration: Duration(seconds: 2),
        ));
      }
    }, builder: (context, state) {
      void _showBottomSheetDeleteAccount() {
        showModalBottomSheet(
            backgroundColor: AppColors.transparent,
            isScrollControlled: true,
            context: context,
            builder: (context) => BlocBuilder<MenuCubit, MenuState>(
                  builder: (context, state) {
                    return Container(
                      height: 170.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              40.0), // Adjust the radius as needed
                          topRight: Radius.circular(
                              40.0), // Adjust the radius as needed
                        ),
                        color: Colors.white,
                      ),
                      child: state is DeleteAccountInProgress
                          ? Center(
                              child: SizedBox(
                                height: 50.h,
                                child: CircularProgressIndicator(
                                  color: AppColors.orangeColor,
                                ),
                              ),
                            )
                          : Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 20.h),
                                  child: Text(
                                    AppStrings.areYouSureYouWantToDeleteAccount,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.5,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: FontFamilies.alexandria,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 47.h,
                                ),
                                Row(
                                  textDirection: TextDirection.rtl,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      onTap: () {
                                        menuCubit.deleteAccount();
                                      },
                                      child: Container(
                                        height: 56.h,
                                        width: 107.w,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(16.r),
                                        ),
                                        child: Center(
                                          child: Text(
                                            AppStrings.yes,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily:
                                                    FontFamilies.alexandria,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        height: 56.h,
                                        width: 107.w,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.red, width: 2.w),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(16.r),
                                        ),
                                        child: Center(
                                          child: Text(
                                            AppStrings.cancel,
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontFamily:
                                                    FontFamilies.alexandria,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                    );
                  },
                ));
      }

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 300),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(AppAssets.unionGreyImg,
                  width: double.infinity, fit: BoxFit.fill),
              Positioned(
                top: 30,
                right: 6,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      width: 40.w,
                      height: 40.h,
                      child: Transform.scale(
                          scale: 0.45,
                          child: SvgPicture.asset(
                            AppAssets.popUpIcon,
                          ))),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 40, bottom: 10),
                    child: Text(
                      'تعديل الحساب',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Alexandria',
                      ),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey)),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: _image != null
                                  ? Image.file(
                                      File(_image!.path),
                                      fit: BoxFit.fill,
                                      width: 70,
                                      height: 70,
                                    )
                                  : userModel.user?.photo != null
                                      ? Image.network(
                                          '${PreferencesHelper.getUserModel?.user?.photo}',
                                          fit: BoxFit.fill,
                                          width: 70,
                                          height: 70,
                                        )
                                      : SvgPicture.asset(
                                          AppAssets.circleAvatar2,
                                          fit: BoxFit.fill,
                                          width: 70,
                                          height: 70,
                                        ))),
                      InkWell(
                        onTap: () async {
                          final picker = ImagePicker();
                          XFile? pickedFile = await picker.pickImage(
                              source: ImageSource.gallery);
                          if (pickedFile != null) {
                            setState(() {
                              _image = XFile(pickedFile.path);
                            });
                          }
                        },
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: BlocConsumer<SignUpCubit, SignUpState>(
            listener: (context, state) {},
            builder: (context, state) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        children: [
                          TextField(
                              enabled: false,
                              controller: emailController,
                              cursorColor: AppColors.blueColor,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.phone,
                              cursorWidth: 1,
                              decoration: InputDecoration(
                                labelText: 'البريد الالكتروني * ',
                                labelStyle: buildLabelStyle(),
                                focusedBorder: buildUnderlineInputBorder(),
                              )),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                  child: TextField(
                                      controller: nameController,
                                      cursorColor: AppColors.blueColor,
                                      cursorWidth: 1,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        labelText: 'الاسم * ',
                                        labelStyle: buildLabelStyle(),
                                        focusedBorder:
                                            buildUnderlineInputBorder(),
                                      ))),
                              const SizedBox(width: 34),
                              Flexible(
                                  child: TextField(
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.emailAddress,
                                      controller: userNameController,
                                      cursorColor: AppColors.blueColor,
                                      cursorWidth: 1,
                                      decoration: InputDecoration(
                                        labelText: 'اسم المستخدم * ',
                                        labelStyle: buildLabelStyle(),
                                        focusedBorder:
                                            buildUnderlineInputBorder(),
                                      ))),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                    child: TextField(
                                        controller: phoneController,
                                        enabled: false,
                                        keyboardType: TextInputType.phone,
                                        textInputAction: TextInputAction.next,
                                        cursorColor: AppColors.blueColor,
                                        cursorWidth: 1,
                                        decoration: InputDecoration(
                                          labelText: 'رقم الهاتف * ',
                                          labelStyle: buildLabelStyle(),
                                          focusedBorder:
                                              buildUnderlineInputBorder(),
                                        ))),
                                const SizedBox(width: 34),
                                Flexible(
                                    child: TextField(
                                        enabled: false,
                                        controller: whatsappController,
                                        cursorColor: AppColors.blueColor,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.name,
                                        cursorWidth: 1,
                                        decoration: InputDecoration(
                                          labelText: 'رقم الواتساب * ',
                                          labelStyle: buildLabelStyle(),
                                          focusedBorder:
                                              buildUnderlineInputBorder(),
                                        ))),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                    child: TextField(
                                        enabled: false,
                                        controller: nationalIDController,
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.next,
                                        cursorColor: AppColors.blueColor,
                                        cursorWidth: 1,
                                        decoration: InputDecoration(
                                          labelText: 'الرقم القومي * ',
                                          labelStyle: buildLabelStyle(),
                                          focusedBorder:
                                              buildUnderlineInputBorder(),
                                        ))),
                                const SizedBox(
                                  width: 34,
                                ),
                                Flexible(
                                    child: TextField(
                                        controller: JobController,
                                        cursorColor: AppColors.blueColor,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.name,
                                        cursorWidth: 1,
                                        decoration: InputDecoration(
                                          labelText: 'العمل * ',
                                          labelStyle: buildLabelStyle(),
                                          focusedBorder:
                                              buildUnderlineInputBorder(),
                                        ))),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                    child: TextField(
                                        controller: addressController,
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.next,
                                        cursorColor: AppColors.blueColor,
                                        cursorWidth: 1,
                                        decoration: InputDecoration(
                                          labelText: 'العنوان * ',
                                          labelStyle: buildLabelStyle(),
                                          focusedBorder:
                                              buildUnderlineInputBorder(),
                                        ))),
                                const SizedBox(
                                  width: 34,
                                ),
                                Flexible(
                                    child: TextField(
                                        controller:
                                            previousExperienceController,
                                        cursorColor: AppColors.blueColor,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.name,
                                        cursorWidth: 1,
                                        decoration: InputDecoration(
                                          labelText: 'الخبرة السابقة * ',
                                          labelStyle: buildLabelStyle(),
                                          focusedBorder:
                                              buildUnderlineInputBorder(),
                                        ))),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 14.h),
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(color: Colors.black26),
                                  ),
                                  child: Center(
                                    child: DropdownButton2<String>(
                                      underline: SizedBox.shrink(),
                                      isExpanded: true,
                                      items: signUpCubit.citiesList
                                          .map((City city) =>
                                              DropdownMenuItem<String>(
                                                value: city.name ??
                                                    "", // Assuming city.name is a String
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    city.name ?? "",
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    maxLines:
                                                        2, // Set text direction to RTL
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                      onChanged: (String? cityName) {
                                        selectedCityName = cityName;
                                        selectedAreaName = null;
                                        setState(() {});
                                        // Find the corresponding city object based on the selected city name
                                        final selectedCity =
                                            signUpCubit.citiesList.firstWhere(
                                          (city) => city.name == cityName,
                                          orElse: () => signUpCubit.citiesList
                                              .first, // Default to the first city
                                        );

                                        signUpCubit.cityId =
                                            selectedCity.id?.toInt() ?? 0;
                                        signUpCubit.fetchAreaData();
                                      },
                                      hint: Padding(
                                        padding: EdgeInsets.only(right: 8),
                                        child: Text(
                                          selectedCityName ?? 'المحافظة',
                                          style: TextStyle(
                                              color: AppColors.blueColor6,
                                              fontFamily:
                                                  FontFamilies.alexandria,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      style: TextStyle(
                                        fontFamily: FontFamilies.alexandria,
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                      buttonStyleData: ButtonStyleData(
                                        height: 40,
                                        width: 160.w,
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        maxHeight: 200,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            border: Border.all(
                                                color: Colors.transparent)),
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 40,
                                      ),
                                      dropdownSearchData: DropdownSearchData(
                                        searchController: textEditingController,
                                        searchInnerWidgetHeight: 50,
                                        searchInnerWidget: Container(
                                          height: 50,
                                          padding: const EdgeInsets.only(
                                            top: 8,
                                            bottom: 4,
                                            right: 8,
                                            left: 8,
                                          ),
                                          child: TextFormField(
                                            expands: true,
                                            maxLines: null,
                                            controller: textEditingController,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 8,
                                              ),
                                              hintTextDirection:
                                                  TextDirection.rtl,
                                              hintText: 'ابحث عن محافظة....',
                                              hintStyle:
                                                  const TextStyle(fontSize: 12),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                          ),
                                        ),
                                        searchMatchFn: (item, searchValue) {
                                          final myItem = signUpCubit.citiesList
                                              .firstWhere((element) =>
                                                  element.name == item.value);
                                          return myItem.name!
                                                  .contains(searchValue) ||
                                              item.value
                                                  .toString()
                                                  .contains(searchValue);
                                        },
                                      ),
                                      onMenuStateChange: (isOpen) {
                                        if (!isOpen) {
                                          textEditingController.clear();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 14.h),
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(color: Colors.black26),
                                  ),
                                  child: Center(
                                    child: DropdownButton2<String>(
                                      underline: const SizedBox.shrink(),
                                      alignment: Alignment.centerRight,
                                      items: signUpCubit.areasList
                                          .map((Areas area) =>
                                              DropdownMenuItem<String>(
                                                value: area.name ??
                                                    "", // Assuming city.name is a String
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    area.name ?? "",
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Alexandria'),
                                                  ),
                                                ),
                                              ))
                                          .toSet()
                                          .toList(),
                                      onChanged: (String? areaName) {
                                        selectedAreaName = areaName;
                                        signUpCubit.fetchAreaData();
                                      },
                                      isExpanded: true,
                                      hint: Padding(
                                        padding: EdgeInsets.only(right: 8),
                                        child: Text(
                                          selectedAreaName ?? 'المركز',
                                          style: TextStyle(
                                              color: AppColors.blueColor6,
                                              fontFamily:
                                                  FontFamilies.alexandria,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ), //) Set the selected value
                                      style: TextStyle(
                                        fontFamily: FontFamilies.alexandria,
                                        fontSize: 12,
                                        height: 1.0,
                                        color: Colors.black,
                                      ),
                                      buttonStyleData: ButtonStyleData(
                                        //padding: EdgeInsets.only(right: 10.w),
                                        height: 40,
                                        width: 160.w,
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        maxHeight: 200,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            border: Border.all(
                                                color: Colors.transparent)),
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 40,
                                      ),
                                      dropdownSearchData: DropdownSearchData(
                                        searchController:
                                            textEditingController2,
                                        searchInnerWidgetHeight: 50,
                                        searchInnerWidget: Container(
                                          height: 50,
                                          padding: const EdgeInsets.only(
                                            top: 8,
                                            bottom: 4,
                                            right: 8,
                                            left: 8,
                                          ),
                                          child: TextFormField(
                                            expands: true,
                                            maxLines: null,
                                            controller: textEditingController2,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 8,
                                              ),
                                              hintTextDirection:
                                                  TextDirection.rtl,
                                              hintText: 'ابحث عن مركز....',
                                              hintStyle:
                                                  const TextStyle(fontSize: 12),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                          ),
                                        ),
                                        searchMatchFn: (item, searchValue) {
                                          final myItem = signUpCubit.areasList
                                              .firstWhere((element) =>
                                                  element.name == item.value);
                                          return myItem.name!
                                                  .contains(searchValue) ||
                                              item.value
                                                  .toString()
                                                  .contains(searchValue);
                                        },
                                      ),
                                      onMenuStateChange: (isOpen) {
                                        if (!isOpen) {
                                          textEditingController2.clear();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 12.h),
                            child: Center(
                              child:
                                  BlocBuilder<EditAccountCubit, CubitBaseState>(
                                builder: (context, state) {
                                  return ElevatedButton(
                                    onPressed: () {
                                      context
                                          .read<EditAccountCubit>()
                                          .editAccountData(
                                              file: _image,
                                              name: nameController.text,
                                              email: emailController.text,
                                              password: passwordController.text,
                                              context: context,
                                              phone: phoneController.text,
                                              gender:
                                                  '${PreferencesHelper.getUserModel?.user?.gender}',
                                              address: addressController.text,
                                              job: JobController.text,
                                              governorate: selectedCityName,
                                              whatsAppNumber:
                                                  whatsappController.text,
                                              cityCenter: selectedAreaName,
                                              previousExperience:
                                                  previousExperienceController
                                                      .text,
                                              education: 'education');
                                    },
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor:
                                            AppColors.orangeColor,
                                        fixedSize: Size(95.w, 48.h),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.r))),
                                    child: state == CubitBaseState.loading
                                        ? CircularProgressIndicator.adaptive(
                                            backgroundColor: Colors.white,
                                          )
                                        : Text(
                                            'حفظ',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily:
                                                  FontFamilies.alexandria,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showBottomSheetDeleteAccount();
                          },
                          child: Padding(
                            padding: EdgeInsets.only(top: 30.h),
                            child: Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Container(
                                width: 115.w,
                                height: 41.h,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(6.r),
                                      bottomLeft: Radius.circular(6.r),
                                    )),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    settingsIcon,
                                    SizedBox(width: 11.w),
                                    mentorshipText,
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    duration: const Duration(milliseconds: 400),
                                    child: ChangePasswordAfterLoginScreen()));
                          },
                          child: Padding(
                            padding: EdgeInsets.only(top: 30.h),
                            child: Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Container(
                                width: 115.w,
                                height: 41.h,
                                decoration: BoxDecoration(
                                    color: AppColors.orangeColor,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(6.r),
                                      bottomRight: Radius.circular(6.r),
                                    )),
                                child: Center(
                                  child: changePasswordText,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        // bottomNavigationBar: Padding(
        //   padding: EdgeInsets.only(left: 25, right: 25, bottom: 20),
        //   child: Row(
        //     children: [
        //       InkWell(
        //         onTap: () {
        //           Navigator.push(
        //               context,
        //               PageTransition(
        //                   type: PageTransitionType.leftToRight,
        //                   duration: const Duration(milliseconds: 530),
        //                   child: const CompleteEditAccountScreen()));
        //         },
        //         child: const CircleAvatar(
        //           backgroundColor: AppColors.greyContainerColor,
        //           radius: 17,
        //           child: Icon(
        //             Icons.arrow_left,
        //             color: Colors.white,
        //           ),
        //         ),
        //       ),
        //       Spacer(),
        //       Padding(
        //         padding: EdgeInsets.only(right: 15.w),
        //         child: BlocBuilder<EditAccountCubit, CubitBaseState>(
        //           builder: (context, state) {
        //             return ElevatedButton(
        //               onPressed: () {
        //                 context.read<EditAccountCubit>().editAccountData(
        //                     name: nameController.text,
        //                     email: emailController.text,
        //                     password: passwordController.text,
        //                     context: context,
        //                     phone: phoneController.text,
        //                     gender:
        //                         '${PreferencesHelper.getUserModel?.user?.gender}',
        //                     address: addressController.text,
        //                     job: JobController.text,
        //                     governorate: governorateController.text,
        //                     whatsAppNumber: whatsappController.text,
        //                     cityCenter: centerController.text,
        //                     previousExperience: previousExperienceController.text,
        //                     education: 'education');
        //               },
        //               style: ElevatedButton.styleFrom(
        //                   elevation: 0,
        //                   backgroundColor: AppColors.orangeColor,
        //                   fixedSize: Size(230.w, 50.h),
        //                   shape: RoundedRectangleBorder(
        //                       borderRadius: BorderRadius.circular(5))),
        //               child: state == CubitBaseState.loading
        //                   ? CircularProgressIndicator.adaptive(
        //                       backgroundColor: Colors.white,
        //                     )
        //                   : Text(
        //                       'حفظ',
        //                       style: TextStyle(
        //                         color: Colors.white,
        //                         fontFamily: 'Alexandria',
        //                         fontSize: 11,
        //                         fontWeight: FontWeight.w500,
        //                       ),
        //                     ),
        //             );
        //           },
        //         ),
        //       ),
        //       Spacer(),
        //     ],
        //   ),
        // ),
      );
    });
  }

  UnderlineInputBorder buildUnderlineInputBorder() {
    return const UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xffD9D9D9)),
    );
  }

  TextStyle buildLabelStyle([Color? color]) {
    return TextStyle(
      color: color ?? const Color(0xffBDBDBD),
      fontWeight: FontWeight.w400,
      fontSize: 10,
      fontFamily: 'Alexandria',
    );
  }

  get mentorshipText => Text(
        AppStrings.deleteAccount,
        style: TextStyle(
            fontFamily: FontFamilies.alexandria,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 10),
      );
  get changePasswordText => Text(
        AppStrings.changePasswordText,
        style: TextStyle(
            fontFamily: FontFamilies.alexandria,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 10),
      );
  get settingsIcon => SvgPicture.asset(
        AppAssets.deleteAccIcon,
        width: 14.w,
      );
}
