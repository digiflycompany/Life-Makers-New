import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/features/home_page/cubit/app_layout_cubit/app_layout_states.dart';

class AppLayoutCubit extends Cubit<AppLayoutState> {
  AppLayoutCubit() : super(AppLayoutInitial());

  static AppLayoutCubit get(context) => BlocProvider.of(context);

  int selectBtn = 0;
  late PageController pageController = PageController(initialPage: selectBtn);

  void selectedButton(int index) {
    selectBtn = index;
    emit(ChangeNavState());
  }
}
