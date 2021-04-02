
import 'package:dartz/dartz.dart';
import 'package:food_app/Dependencies/app_constants.dart';
import 'package:food_app/Dependencies/failure.dart';
import 'package:food_app/HomeSreen/Data/Modals/food_item_modal.dart';
import 'package:food_app/HomeSreen/Domain/Entity/food_item.dart';
import 'package:food_app/HomeSreen/Domain/Repository/get_data_from_api.dart';

class RepositoryImpl implements GetDataFromApi{
  @override
  List<String> foodNames = ["Butter Chicken", "Instant Pot Butter Chicken", "Tandoori Chicken", "Chicken Tikka Masala", "Chicken Vindaloo Curry", "Rogan Josh (Red Lamb)", "Malai Kofta",
    "Chole (Chickpea Curry)", "Palak Paneer (Spinach and Cottage Cheese)", "Kaali Daal (Black Lentils)"];
  List<FoodItemModal> data = [];
  Future<Either<Failure, List<FoodItem>>> getFoodDataFromApi() {

      for(int i=1 ; i<= AppConstants.instance.foodItemsCount; i++){
        int j = i-1;
        data.add(FoodItemModal(foodImage: "assets/image_$i.jpg", foodName: foodNames[j]));
      }
      return Future.value(Right(data));
  }

}