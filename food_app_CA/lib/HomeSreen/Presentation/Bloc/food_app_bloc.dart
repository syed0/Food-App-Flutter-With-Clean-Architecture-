import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:food_app/HomeSreen/Domain/Entity/food_item.dart';
import 'package:food_app/HomeSreen/Domain/UseCases/getdata.dart';
import 'package:food_app/HomeSreen/Domain/UseCases/set_counter.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

part 'food_app_event.dart';
part 'food_app_state.dart';

class FoodAppBloc extends Bloc<FoodAppEvent, FoodAppState> {
  final GetData getData;
  FoodAppBloc({this.getData}) : super(FoodAppEmpty());

  @override
  Stream<FoodAppState> mapEventToState(
    FoodAppEvent event,
  ) async* {
   if (event is GetDataFromApi){
        yield Loading();
        final response = await getData.get();
        yield response.fold((failure) => throw UnimplementedError(),
                (data) {
          final foodIemsLoadedState =  FoodIemsLoaded(foodItems: data);
          foodIemsLoadedState.setCounterItems();
         return foodIemsLoadedState;
        });
   }else if(event is SetCounterEvent){
     if(event.counterType == CounterType.Increament){
       event.setCounterList[event.index].increament();
      yield SetCounterLoaded(setCounterList: event.setCounterList);
     }else if(event.counterType == CounterType.Decreament){
       event.setCounterList[event.index].decreament();
       yield SetCounterLoaded(setCounterList:event.setCounterList);
     }

   }else if( event is CheckCheckOutBtnEvent){
     List<SetCounter> selectedList = [];
     for(int i=0; i< event.foodItemsList.length ; i++){
       if(event.foodItemsList[i].isSelected){
         selectedList.add(event.foodItemsList[i]);
       }
     }
     yield CheckoutBtnStateLoaded(selectedList: selectedList, isHidden: selectedList.length == 0, foodItemData: event.foodItemsList);
   }
  }
}
