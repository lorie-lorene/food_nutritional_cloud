import 'package:flutter/material.dart';
import 'package:pretty_gauge/pretty_gauge.dart';
import 'package:share_plus/share_plus.dart';

class ScoreScreen extends StatelessWidget {
  final double bmiscore;
  final int age;
  String ? bmiStatus;
  String ? bmiInterpretation;
  Color? bmiStatusColor;

  ScoreScreen({super.key, required this.age, required this.bmiscore});

  @override
  Widget build(BuildContext context) {
    setBmiInterpretation();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("BMI SCORE"),
        backgroundColor: Colors.blue,
      ),
      body:  Container(
        padding: const EdgeInsets.all(8.0),
    child: Card(
    elevation: 12,
    shape: const RoundedRectangleBorder(),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      const Text("Your Score",style: TextStyle(fontSize: 30,color: Colors.blue),
      ),
       const  SizedBox(
          height: 10,
        ),
        PrettyGauge(
          gaugeSize: 300,
          minValue: 0,
          maxValue: 40,
          segments: [
            GaugeSegment('underWeight', 18.5, Colors.red),
            GaugeSegment('Normal', 6.4, Colors.green),
            GaugeSegment('OverWeight', 5, Colors.orange),
            GaugeSegment('Obese', 10.1, Colors.pink),
          ],
          valueWidget: Text(bmiscore.toStringAsFixed(1),
          style: const TextStyle(fontSize: 40),
          ),
          currentValue: bmiscore.toDouble(),
          needleColor: Colors.lightBlue,
        ),
        const SizedBox(height: 10,),
        Text(bmiStatus!,
        style: TextStyle(fontSize: 20,color: bmiStatusColor!),
        ),
        const SizedBox(height: 10,),
        Text(bmiInterpretation!,
          style: const TextStyle(fontSize: 15),
        ),
        const SizedBox(height: 20,),
        Row(
          mainAxisAlignment:  MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: const Text("Re-Calculate")),
          const SizedBox(width: 10,),
          ElevatedButton(
              onPressed: (){
                Share.share("your BMI is ${bmiscore.toStringAsFixed(1)}  at age $age");
              },
              child: const Text("Share"))
        ],
        )
    
    ],
    )))
    );
  }
  void setBmiInterpretation(){
    if(bmiscore> 30){
      bmiStatus="Obese";
      bmiInterpretation="Please work to reduce obesity";
      bmiStatusColor= Colors.pink;
    }
    if(bmiscore>= 25){
      bmiStatus="OverWeight";
      bmiInterpretation="Please do regular exercise for reduce your weight";
      bmiStatusColor= Colors.orange;
    }
    if(bmiscore>=18.5){
      bmiStatus="Normal";
      bmiInterpretation="Enjoy your sweet fit";
      bmiStatusColor= Colors.green;
    }
    if(bmiscore<18.5){
      bmiStatus="UnderWeight";
      bmiInterpretation="Try to increse your weight";
      bmiStatusColor= Colors.red;
    }
  }
}
