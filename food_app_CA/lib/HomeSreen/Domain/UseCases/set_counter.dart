
import 'package:food_app/HomeSreen/Domain/Entity/food_item.dart';
class SetCounter{
  int count = 0;
  bool isSelected = false;
  FoodItem foodItem;
  void increament(){
    count = count + 1;
    isSelected = true;
  }
  void decreament(){
    if(count != 0) {
      count = count - 1;
      if (count == 0){
        isSelected = false;
      }
    }
  }
}
