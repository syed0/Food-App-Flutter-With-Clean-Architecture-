part of 'food_app_bloc.dart';

enum CounterType{
  Increament,
  Decreament
}

@immutable
abstract class FoodAppEvent {}

class GetDataFromApi extends FoodAppEvent{

}

class SetCounterEvent extends FoodAppEvent{
  final CounterType counterType;
  final int index;
  final List<SetCounter> setCounterList;
  SetCounterEvent({this.counterType,this.index, this.setCounterList});
}
class CheckCheckOutBtnEvent extends FoodAppEvent{

  final List<SetCounter> foodItemsList;
  CheckCheckOutBtnEvent({this.foodItemsList});
}