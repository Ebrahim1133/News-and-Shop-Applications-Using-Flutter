// @dart=2.9
import 'package:bloc/bloc.dart';
import 'package:flutter_abdullamansour/models/shop_app/search_model.dart';
import 'package:flutter_abdullamansour/modules/shop_app/search/cubit/states.dart';
import 'package:flutter_abdullamansour/shared/components/constants.dart';
import 'package:flutter_abdullamansour/shared/network/end_points.dart';
import 'package:flutter_abdullamansour/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel model;

  void search(String text) {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value) {
      model = SearchModel.fromJson(value.data);

      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
