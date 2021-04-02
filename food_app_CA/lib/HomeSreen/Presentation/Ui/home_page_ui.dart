import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/HomeSreen/Data/Repository/repositry_implimentation.dart';
import 'package:food_app/HomeSreen/Domain/UseCases/getdata.dart';
import 'package:food_app/HomeSreen/Presentation/Bloc/food_app_bloc.dart';
import 'checkout_page_ui.dart';
import 'file:///C:/Users/danaq/AndroidStudioProjects/food_app/lib/Dependencies/app_constants.dart';

void main() {
  runApp(MyFoodApp());
}

class MyFoodApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => FoodAppBloc(getData: GetData(repository: RepositoryImpl())),
       child : MaterialApp(
      title: AppConstants.instance.appName,
      theme: ThemeData(
          primarySwatch: AppConstants.instance.appThemeColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,),

    home: Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text("${AppConstants.instance.appName}")),
      ),
      bottomNavigationBar: BlocBuilder<FoodAppBloc, FoodAppState>(
        builder: (context, state){
          if (state is CheckoutBtnStateLoaded) {
            return Opacity(
              opacity: state.isHidden? 0: 1,
              child: BottomAppBar(
                  child: FlatButton(key: Key("CheckoutBtn"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CheckoutScreen(selectedDataList: state.selectedList,),
                        ),
                      );
                    },
                    color: Colors.grey[300],
                    child: Text(" Checkout ",
                      style: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 25,),
                    ),
                  ),
                ),
            );

          }
          return BottomAppBar();
        },
    ),
      body: AppBody()
      ),
    ),
    );
  }

}

class AppBody extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FoodAppBloc>(context).add(GetDataFromApi());
    return BlocBuilder<FoodAppBloc, FoodAppState>(
      builder: (context, state){
        if (state is Error){
          return Container(child: Text(state.message),);
        }else if(state is FoodIemsLoaded){
          return ListView.builder(padding: EdgeInsets.fromLTRB(10, 12, 12, 10),
              itemCount: state.foodItemsWithSetCounter.length,
              itemBuilder: (BuildContext context, int index){
                return  FoodItemCell(indexForItem : index , foodItemDataList: state.foodItemsWithSetCounter);
              });
        }else if (state is SetCounterLoaded){
          return ListView.builder(padding: EdgeInsets.fromLTRB(10, 12, 12, 10),
              itemCount: state.setCounterList.length,
              itemBuilder: (BuildContext context, int index){
                return  FoodItemCell(indexForItem : index , foodItemDataList: state.setCounterList);
              });
        }else if( state is CheckoutBtnStateLoaded){
          return ListView.builder(padding: EdgeInsets.fromLTRB(10, 12, 12, 10),
              itemCount: state.foodItemData.length,
              itemBuilder: (BuildContext context, int index){
                return  FoodItemCell(indexForItem : index , foodItemDataList: state.foodItemData);
              });
        }
        return Container();
      },

    );
  }

}
class FoodItemCell extends StatelessWidget{
  final indexForItem;
  final foodItemDataList;
  FoodItemCell({this.indexForItem,this.foodItemDataList});

  @override
  Widget build(BuildContext context) {
          return  Container(
            color: Colors.grey[300],
            child: Column(children: [
              Image.asset(foodItemDataList[indexForItem].foodItem.foodImage,
                height: 300,
                width: 300,) ,
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children : [
                  Container(
                    width: 100,
                    child: Text(foodItemDataList[indexForItem].foodItem.foodName,
                        style: TextStyle(fontWeight: FontWeight.w400,
                          fontSize: 20,)
                    ),
                  ),
                  SizedBox(width: 30,),
                  Container(
                    child: Row(mainAxisAlignment : MainAxisAlignment.spaceEvenly,
                      children: [
                        FlatButton(onPressed: (){
                          BlocProvider.of<FoodAppBloc>(context).add(SetCounterEvent(counterType: CounterType.Decreament, index: indexForItem, setCounterList: foodItemDataList));
                          BlocProvider.of<FoodAppBloc>(context).add(CheckCheckOutBtnEvent(foodItemsList: foodItemDataList));
                        },
                            child: Text("-",
                                style: TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 40,)
                            )
                        ),
                        Text("${foodItemDataList[indexForItem].count}",
                            style: TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 20,)
                        ),
                        FlatButton(onPressed: (){
                          BlocProvider.of<FoodAppBloc>(context).add(SetCounterEvent(counterType: CounterType.Increament, index: indexForItem, setCounterList: foodItemDataList));
                          BlocProvider.of<FoodAppBloc>(context).add(CheckCheckOutBtnEvent(foodItemsList: foodItemDataList));
                        }, child: Text("+",
                            key: Key("PlusBtn"),
                            style: TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 35,)
                        )
                        ),
                      ], ),
                  )
                ],)
            ],),
          );
  }
}

