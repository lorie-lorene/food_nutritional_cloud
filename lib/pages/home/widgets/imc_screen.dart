import 'dart:math';

import 'package:flutter/material.dart';
import 'package:food_nutritional_cloud/pages/home/widgets/score_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

import 'age_weight_widget.dart';
import 'gender_widget.dart';
import 'height_widget.dart';
class ImcScreen extends StatefulWidget {
  const ImcScreen({super.key});

  @override
  State<ImcScreen> createState() => _ImcScreenState();
}

class _ImcScreenState extends State<ImcScreen> {
  int _gender=0;
  int _height= 150;
  int _age=25;
  int _weight=50;
  bool _isFinished=false;
  double _bmiScore= 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('BMI Calculator'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 12,
            shape: const RoundedRectangleBorder(),
            child: Column(
              children: [
                // creation's widget
                GenderWidget(
                  onChange: (genderval){
                  _gender =genderval;
                },
                ),
                HeightWidget(onChange: (heightVal){
                  _height= heightVal;
                },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AgeWeightWidget(
                        onChange:(ageVal){
                          _age= ageVal;

                        },
                        title:"Age",
                        initValue:25,
                        max: 100,
                        min:0),
                    AgeWeightWidget(
                        onChange:(weightVal){
                          _weight= weightVal;

                        },
                        title:"Weight(kg)",
                        initValue:55,
                        max: 200,
                        min:0),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 70),

                  child: SwipeableButtonView(
                    isFinished: _isFinished,
                      onFinish: () async {
                      await Navigator.push(context,PageTransition(
                          child: ScoreScreen(age: _age, bmiscore: _bmiScore),
                          type:PageTransitionType.fade ));
                        setState(() {
                          _isFinished= false;
                        });
                      },
                      onWaitingProcess: (){
                        calculatebmi();
                      Future.delayed(
                        Duration(seconds: 2),(){
                          setState(() {
                            _isFinished= true;
                          });
                      }
                      );
                      },
                      activeColor: Colors.blue,
                      buttonWidget: const Icon(
                        Icons.arrow_forward_ios_rounded,color: Colors.black87,
                      ),
                      buttonText: "CALCULATE"),
                )
              ],
            ),
          ),
        ),
        ));
  }
  void calculatebmi(){
    _bmiScore= _weight/pow(_height/100, 2);
  }
}
