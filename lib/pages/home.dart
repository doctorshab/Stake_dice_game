import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Stake Dice Game'),
        centerTitle: true,
      ),
      body: Center(
        child :Column(
        children: <Widget>[
          SizedBox(height: 350.0,),
          ElevatedButton.icon(onPressed: (){
            Navigator.pushNamed(context, '/location',);
          },
          icon:Icon(Icons.play_arrow_rounded
          ),
            label: Text('PLAY'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[300],
              foregroundColor: Colors.black,
            ),
          )
        ],
      ),)
    );
  }
}
