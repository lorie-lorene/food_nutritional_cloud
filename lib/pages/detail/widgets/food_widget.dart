import 'package:flutter/material.dart';
class FoodWidget extends StatefulWidget {
  const FoodWidget({super.key});

  @override
  State<FoodWidget> createState() => _FoodWidgetState();
}
bool isDone=false;
class _FoodWidgetState extends State<FoodWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
          child: Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              borderRadius:BorderRadius.circular(20),
              color: Colors.white38,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 2),

                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  imagee(),
                  const SizedBox( width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('title',style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold),
                            ),
                            Checkbox(value:isDone, onChanged: (value){
                              setState(() {
                                isDone=!isDone;
                              });
                            })
                          ],
                        ),
                        SizedBox(height: 8),
                        Text('subtitle',style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold,color: Colors.grey.shade300),
                        ),
                        Spacer(

                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              Container(
                                width: 90,
                                height: 28,
                                decoration: BoxDecoration(
                                  color:Colors.blue,
                                  borderRadius: BorderRadius.circular(18)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 13,vertical: 6),
                                  child: Row(
                                    children: [
                                      Icon(Icons.timelapse),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('Date',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 10,),
                              Container(
                                width: 90,
                                height: 28,
                                decoration: BoxDecoration(
                                    color:Colors.white,
                                    borderRadius: BorderRadius.circular(18)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 13,vertical: 6),
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('Edit',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )

                ],
              ),
            ),
          ),
        );
  }
 Widget  imagee(){
    return  Container(
      height: 130,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            image: AssetImage('assets/images/avatar.png'),
            fit: BoxFit.cover
        ),

      ),
    );
  }
}
