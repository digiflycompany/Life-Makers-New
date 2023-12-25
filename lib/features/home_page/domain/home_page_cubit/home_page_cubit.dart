import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/features/home_page/domain/home_page_cubit/home_page_states.dart';
import '../../data/models/nav_bar_model.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageInitial());
  late PageController pageController;
  int selectBtn = navBtn2.length - 1;

  void initialState(){
    pageController = PageController(initialPage: selectBtn);
    emit(HomePageSuccess());
  }
  void selectedButton(int index){
     selectBtn =index;
     emit(ChangeNavState());
  }

}