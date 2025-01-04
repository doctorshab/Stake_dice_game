import 'package:flutter/material.dart';
import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';


class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  int coins =10, buttonindex=-1, wager=0, winmultipler=0;
  Random random =Random();List<int>nums=[1,1,1,1];
  List<String>history=[];

  final wagerinput= TextEditingController();
  void youLost( BuildContext context ){           // dialog that pops when u lose
    showDialog(context: context, builder: (BuildContext context){
    return AlertDialog(
      title: const Text('YOU LOST THE GAME'),
      actions: <Widget>[
        IconButton(onPressed: (){         //exit
          Navigator.pop(context); Navigator.pop(context);
        }, icon: const Icon(Icons.home)),
        const SizedBox(width: 140.0,),
        IconButton(onPressed: (){           //restart
          setState(() {
            coins=10;buttonindex=-1;history.clear();
          });Navigator.pop(context);
        }, icon: const Icon(Icons.restart_alt)),
      ],
    );
    });
  }

  void setting(BuildContext context){        //SETTINGS
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('SETTINGS'),
          content: Column(
            children: <Widget>[
              TextButton(onPressed: (){    //EXIT
                Navigator.pop(context);  Navigator.pop(context);
              }, child: const Text('EXIT')),
              TextButton(onPressed: (){   //HISTORY DIALOG PAGE
                showDialog(context: context, builder: (BuildContext context){
                  return AlertDialog(
                    title:const Text('HISTORY') ,
                    content: SingleChildScrollView(
                      child: Column(
                        children: history.map((index){
                          return Text(index);
                        }).toList(),
                      ),
                    ),
                    actions: <Widget>[
                      IconButton(onPressed: (){Navigator.pop(context);  Navigator.pop(context);},
                          icon: const Icon(Icons.dangerous))
                    ],
                  );
                });
              }, child: const Text('HISTORY'))
            ],
          ),
          actions: <Widget>[IconButton(onPressed: (){Navigator.pop(context);},
              icon: const Icon(Icons.dangerous))],
        );
      },
    );
  }


  void dice(){
    int wager = int.tryParse(wagerinput.text) ?? 0;
    if(winmultipler==0){
      Fluttertoast.showToast(msg: "Please chose the type of wager");wagerinput.clear();return;
    }
    if( (wager * winmultipler) >coins){
      Fluttertoast.showToast(msg: "wager too high");return;
    }
    else if( wager<=0 ){ Fluttertoast.showToast(msg: "please input a valid wager");return;}
    else {

      nums = List.generate(4, (index) => random.nextInt(6) + 1);
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
        history.add("numbers : $numbers YOU WIN ${winmultipler * wager} coins\ncoins:$coins");
      }
      else{
        setState(() {
          coins -= (winmultipler*wager);
        });
        Fluttertoast.showToast(msg: "numbers : $numbers YOU LOSE ${winmultipler * wager} coins",
            gravity: ToastGravity.BOTTOM);
        history.add("numbers : $numbers YOU LOSE ${winmultipler * wager} coins\ncoins:$coins");
        if(coins==0 || coins==1){
          youLost(context);
        }
      }
    }
    setState(() {
      wagerinput.clear();winmultipler=0;buttonindex=-1;
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            const SizedBox(width: 80.0,),
            Text('coins : $coins'),
           const SizedBox(width: 100.0,),
            IconButton(onPressed: (){ // restart button
              setState(() {
                coins=10;buttonindex=-1;history.clear();
              });
            }, icon: const Icon(Icons.restart_alt),),
          ],
        ),
        leading:
          IconButton(onPressed: (){
            setting(context);
          }, icon: const Icon(Icons.settings)),
        backgroundColor: Colors.blue,
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
         const SizedBox(height: 5.0,),
        TextField(
         keyboardType: TextInputType.number,
          controller: wagerinput,
          decoration: const InputDecoration(
            hintText: 'ENTER A NUMBER',
            border: OutlineInputBorder(),
          ),
        ),
          const SizedBox(height: 20.0,),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(onPressed: () {
                setState(() {
                  winmultipler=2;buttonindex=2;
                });
              },
                style: ElevatedButton.styleFrom(
                    backgroundColor: (buttonindex==2) ? Colors.blue[600] : Colors.blue[200]),
                child: const Text('  2 alike  '),
              ),
              ElevatedButton(onPressed: () {
                setState(() {
                  winmultipler=3;buttonindex=3;
                });
              },
                style: ElevatedButton.styleFrom(
                    backgroundColor: (buttonindex==3) ? Colors.blue[600] : Colors.blue[200]),
                child: const Text('  3 alike  '),
              ),
              ElevatedButton(onPressed: () {
                setState(() {
                  winmultipler=4;buttonindex=4;
                });
              },
                style: ElevatedButton.styleFrom(
                    backgroundColor: (buttonindex==4) ? Colors.blue[600] : Colors.blue[200]),
                child: const Text('  4 alike  '),
              )
            ],
          ),
          const SizedBox(height:40.0,),
          ElevatedButton(onPressed: dice,
          style:ElevatedButton.styleFrom(
            padding: EdgeInsets.all(20.0),
            textStyle: TextStyle(fontSize: 30)
          ) , child: const Text('START'),
          )
        ],
      ),
    );
  }
}
