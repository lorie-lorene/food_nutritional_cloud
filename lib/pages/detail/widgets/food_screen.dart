import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:food_nutritional_cloud/pages/detail/widgets/food_widget.dart';
class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  @override
  bool show=true;
  Widget build(BuildContext context) {
    return get();
  }
    Widget get(){
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Visibility(
        visible: show,
        child: FloatingActionButton(
            onPressed: (){},
        backgroundColor: Colors.blue,
        child: Icon(Icons.add,size: 30,)
          ,),
      ),
      body: SafeArea(
          child: NotificationListener<UserScrollNotification>(
            onNotification: (notification){
              if(notification.direction==ScrollDirection.forward){
                setState(() {
                  show=true;
                });
              }
              if(notification.direction==ScrollDirection.reverse)
              {
                setState(() {
                  show=false;
                });
              }
              return true;
            },
            child: ListView.builder(itemBuilder: (context,index){
              return FoodWidget();
            },
              itemCount: 10,
            ),
          )),
    );
  }
}
