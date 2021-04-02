
import 'package:dartz/dartz.dart';
import 'package:food_app/Dependencies/failure.dart';
import 'package:food_app/HomeSreen/Domain/Entity/food_item.dart';
import 'package:food_app/HomeSreen/Domain/Repository/get_data_from_api.dart';

class GetData {

  final GetDataFromApi repository;
  GetData({this.repository});
  Future<Either<Failure, List<FoodItem>>> get() async{
       return await repository.getFoodDataFromApi();
  }

  }