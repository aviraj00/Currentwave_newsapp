import 'dart:async';

import 'package:currentwave/splash/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2),(){
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Home()));
    });
  }
  @override
  Widget build(BuildContext context) {
    final height =MediaQuery.sizeOf(context).height*1;
    final width =MediaQuery.sizeOf(context).width*.5;

    return  Scaffold(
      body: Container(
        color: Color(0xff95a9ff),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Image.asset('assets/images/splash.jpg',
          fit: BoxFit.cover,
            height: height*.4,
            
          ),SizedBox(height: height*.04,),
            Text('Top Headlines',style:GoogleFonts.anton(letterSpacing:.6,color:Colors.white,fontSize:20,fontWeight:FontWeight.bold),),
            SizedBox(height: height*0.04,),

            SpinKitDancingSquare(
              color: Colors.black,
              size: 50,
            )
          ],
        ) ,
      ),
    );
  }
}
