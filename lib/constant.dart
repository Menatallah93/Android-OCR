

import 'package:flutter/material.dart';

const kColorPrimary = Color.fromARGB(255, 4, 0, 52);

// شكل البوكس اللي هكتب فيه
//FlatButton(
//                           height: 50,
//                           minWidth: width * 0.70,
//                           color: Colors.black,
//                           textColor: Colors.white,
//                           onPressed: () => navigateTo(context, Home()),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           child: Text(
//                             'Sign in',
//                             style: TextStyle(fontSize: 15.0),
//                           ),
//                         ),

Widget buttonServices(
{
 required Color color,required String text,required double width,
 required String img , required Function openDialog , required int numPage , required Color colorBar

}
)
{
  return FlatButton(
                           height: 60,
                           minWidth:width ,
                           color: color,
                           textColor: Colors.white,
                           onPressed: () =>openDialog(numPage , text , img , colorBar),
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(10.0),
                          ),
                          //child: Align(

                            //alignment: Alignment.centerLeft,

                            child:
                                Row(
                                  children: [
                                    Ink.image(image: AssetImage(img),fit: BoxFit.cover,
                                        width: 35,
                                        height: 35,

                                        ),

                                    SizedBox(width: 10,),
                                    Container(
                                  child: Text(
                                  text,
                                  style: TextStyle(fontSize: 20.0,color: Colors.black),

                                ),
  ),
  // ),
  ]
                           ),);
}
void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));


