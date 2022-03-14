import 'dart:async';
import 'package:flutter/material.dart';
import 'constant.dart';
import 'home.dart';



main()
{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(

      ) ,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

@override
  void initState() {
  // TODO: implement initState
  super.initState();
  Timer(Duration(seconds: 10), ()
  // ربط الصفحات
  {Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => HomePage()));
  });
}
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var hight=MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kColorPrimary,
      body: Center(
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center ,
          children: [
              Image.asset('assets/11.png' , height:hight*0.4, width: width*0.4,),
              //SizedBox(height:hight*0.1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Pro' ,
                  style: TextStyle(color: Colors.white, fontSize: 40),),
                Text('Scan' ,
                  style: TextStyle(color: Colors.red, fontSize: 40),),
              ],
            ),
            SizedBox(height:hight*0.1,),
              CircularProgressIndicator(
                  valueColor:AlwaysStoppedAnimation(Colors.white10),

              )
          ],
        ),
      ),
    );
  }
}

 