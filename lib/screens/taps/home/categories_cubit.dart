import 'package:almoda/core/service/dio_helper.dart';
import 'package:almoda/core/service/endpoints.dart';
import 'package:almoda/models/all_category_model.dart';
import 'package:bloc/bloc.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitState());
  final dio = DioHelper.dio;
  late CategoryResponse categoryResponse;
  List<Category> categories = [];

  Future<void> getAllCategory() async {
    emit(GetAllCategoriesLoadingState());
    try {
      final response = await dio.get(EndPoints.getAllCategory);
      categoryResponse = CategoryResponse.fromJson(response.data);
      categories = categoryResponse.categories;
      emit(GetAllCategoriesSuccessState());
    } catch (e) {
      emit(GetAllCategoriesErrorState());
    }
  }
}

abstract class CategoriesState {}

class CategoriesInitState extends CategoriesState {}

class GetAllCategoriesLoadingState extends CategoriesState {}

class GetAllCategoriesSuccessState extends CategoriesState {}

class GetAllCategoriesErrorState extends CategoriesState {}
