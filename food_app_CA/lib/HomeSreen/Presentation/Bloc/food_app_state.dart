part of 'food_app_bloc.dart';

@immutable
abstract class FoodAppState {}

class FoodAppEmpty extends FoodAppState {}

class Loading extends FoodAppState {}

class FoodIemsLoaded extends FoodAppState {
  final List<FoodItem> foodItems;
  List<SetCounter> foodItemsWithSetCounter=[];
  FoodIemsLoaded({@required this.foodItems});

  void setCounterItems(){
    for (int i=0; i<foodItems.length; i++){
      final setCounter = SetCounter();
      setCounter.foodItem = foodItems[i];
      foodItemsWithSetCounter.add(setCounter);
    }
  }
}

class SetCounterLoaded extends FoodAppState{
  final List<SetCounter> setCounterList;
 SetCounterLoaded({this.setCounterList});

}

class CheckoutBtnStateLoaded extends FoodAppState{
  final List<SetCounter> selectedList;
  final List<SetCounter> foodItemData;
  final bool isHidden ;
  CheckoutBtnStateLoaded({this.selectedList,this.isHidden = true,this.foodItemData});
}

class Error extends FoodAppState {
  final String message;

  Error({@required this.message}) ;
}