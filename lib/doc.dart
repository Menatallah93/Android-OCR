import 'dart:io';

import 'package:androidocr/constant.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class convertDocTo extends StatefulWidget{


  final String text , imageIcon;
  final Color colorBar;
  final String typeFile ;
  final String nameFile;
  const convertDocTo({Key? key,  required this.text , required this.imageIcon , required this.colorBar ,  required this.nameFile ,  required this.typeFile}) : super(key: key);

  @override
  State<convertDocTo> createState() => _convertDocToState();
}

class _convertDocToState extends State<convertDocTo> {
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var hight=MediaQuery.of(context).size.height;


    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: widget.colorBar,
          leading: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Image.asset(widget.imageIcon ,),
          ),
          title:
          Text(widget.text ,
            style: TextStyle(color: Colors.black, fontSize: 25),),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.settings , color: Colors.black,),
            ),
          ],

        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(widget.typeFile) ,SizedBox(width: 2,) ,Text(":") ,SizedBox(width: 2,), Text(widget.nameFile)
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Material(
                  elevation:  3.0,
                  shadowColor: Colors.grey,

                  borderRadius: BorderRadius.circular(15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(

                      child: TextFormField(
                        maxLines: 4,
                        onTap: () {
                          print('g');

                        },
                        // textAlign: TextAlign.,
                        cursorColor: Colors.black,
                        showCursor: true,
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          suffixIcon:  Icon(Icons.headset , color: Colors.black,size: 30,),

                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                SizedBox(
                  height: 10,
                ),
                /* Material(
                  elevation:  3.0,
                  shadowColor: Colors.grey,

                  borderRadius: BorderRadius.circular(15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(

                      child: TextFormField(
                        maxLines: 4,
                        onTap: () {
                          print('g');

                        },
                        // textAlign: TextAlign.,
                        cursorColor: Colors.black,
                        showCursor: true,
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          suffixIcon:  Icon(Icons.headset , color: Colors.black,size: 30,),

                        ),
                      ),
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }


}
