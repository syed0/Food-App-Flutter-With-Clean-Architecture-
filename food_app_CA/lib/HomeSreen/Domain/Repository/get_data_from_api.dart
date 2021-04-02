import 'package:dartz/dartz.dart';
import 'package:food_app/Dependencies/failure.dart';
import 'package:food_app/HomeSreen/Domain/Entity/food_item.dart';

abstract class GetDataFromApi{

  Future<Either<Failure, List<FoodItem>>>  getFoodDataFromApi();

}