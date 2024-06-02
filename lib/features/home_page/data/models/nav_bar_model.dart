import '../../../../core/utils/app-assets.dart';
import '../../../../core/utils/app-string.dart';
class NavModel {
  final int id;
  final String imagePath;
  final String name;

  NavModel({
    required this.id,
    required this.imagePath,
    required this.name,
  });
}

List<NavModel> navBtn = [
  NavModel(id: 0, imagePath: AppAssets.homeIconSvg, name: AppStrings.mainPage),
  NavModel(id: 1, imagePath: AppAssets.notificationIcon, name: AppStrings.notifications),
  NavModel(id: 2, imagePath: AppAssets.profileIcon, name:AppStrings.personalFile ),
];
class NavModel2 {
  final int id;
  final String imagePath;
  final String name;

  NavModel2({
    required this.id,
    required this.imagePath,
    required this.name,
  });
}

List<NavModel2> navBtn2 = [
  NavModel2(id: 0, imagePath: AppAssets.homeWhiteIcon, name: AppStrings.mainPage),
  NavModel2(id: 1, imagePath: AppAssets.notificationWhiteIcon, name: AppStrings.notifications),
  NavModel2(id: 2, imagePath: AppAssets.profileWhiteIcon, name:AppStrings.personalFile ),
];