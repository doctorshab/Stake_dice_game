import 'package:flutter/material.dart';
import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';


class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  int coins =10;
  int wager=0,winmultipler=0;
  final wagerinput= TextEditingController();

  void dice(){
    int wager = int.tryParse(wagerinput.text) ?? 0;
    if( (wager * winmultipler) >coins){
      Fluttertoast.showToast(msg: "wager too high");
    }
    else if( wager<=0 ){ Fluttertoast.showToast(msg: "please input a valid wager");}
    else {
      Random random =Random();
      List<int> nums = List.generate(4, (index) => random.nextInt(6) + 1);
      Map<int,int> count ={};
      String numbers = nums.join(" ,");
      for(int num in nums){
        count[num]=(count[num] ?? 0) +1;
      } int maxCount=count.values.reduce((a,b) => a>b ? a : b);

      if(maxCount == winmultipler){
        setState(() {
          coins += (winmultipler*wager);
        });
        Fluttertoast.showToast(msg: "numbers : $numbers YOU WIN ${winmultipler * wager} coins",
        gravity: ToastGravity.BOTTOM);
      }
      else{
        setState(() {
          coins -= (winmultipler*wager);
        });
        Fluttertoast.showToast(msg: "numbers : $numbers YOU LOSE ${winmultipler * wager} coins",
            gravity: ToastGravity.BOTTOM);
        if(coins==0){
          Future.delayed(Duration(seconds: 3),(){
            Fluttertoast.showToast(msg: "YOU LOST THE GAME PLAESE RESTART");
          });
        }
      }
    }
    setState(() {
      wagerinput.clear();
    });
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            SizedBox(width: 80.0,),
            Text('coins : $coins'),
            SizedBox(width: 100.0,),
            IconButton(onPressed: (){
              setState(() {
                coins=10;
              });
            }, icon: Icon(Icons.restart_alt),),
          ],
        ),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.exit_to_app)),
        backgroundColor: Colors.blue,
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 5.0,),
        TextField(
         keyboardType: TextInputType.number,
          controller: wagerinput,
          decoration: InputDecoration(
            hintText: 'ENTER A NUMBER',
            border: OutlineInputBorder(),
          ),
        ),
          SizedBox(height: 20.0,),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(onPressed: () {
                setState(() {
                  winmultipler=2;
                });
              }, child: Text('  2 alike  '),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[200]),
              ),
              ElevatedButton(onPressed: () {
                setState(() {
                  winmultipler=3;
                });
              }, child: Text('  3 alike  '),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[200]),
              ),
              ElevatedButton(onPressed: () {
                setState(() {
                  winmultipler=4;
                });
              }, child: Text('  4 alike  '),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[200]),
              )
            ],
          ),
          SizedBox(height:40.0,),
          ElevatedButton(onPressed: dice, child: Text('START'),
          style:ElevatedButton.styleFrom(
            padding: EdgeInsets.all(20.0),
            textStyle: TextStyle(fontSize: 30)
          ) ,
          )
        ],
      ),
    );
  }
}
