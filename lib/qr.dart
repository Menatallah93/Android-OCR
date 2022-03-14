import 'dart:io';

import 'package:androidocr/constant.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

//import 'package:qr_code_scanner/qr_code_scanner.dart';


class convertQRTo extends StatefulWidget{




  final File imageFile;
  final String text , imageIcon;
  final Color colorBar;
   convertQRTo({Key? key, required this.imageFile , required this.text , required this.imageIcon ,  required this.colorBar}) : super(key: key);



    @override
  State<convertQRTo> createState() => _convertQRToState();
}

class _convertQRToState extends State<convertQRTo> {
  //final qrKey = GlobalKey(debugLabel: 'QR');
  //String result = "not yet scan! ";

 // Barcode? barcode;
 // QRViewController? controller;


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
                //الصوره
                Center(child: Image.file(widget.imageFile , width: width * 0.6  ,)),

                SizedBox(
                  height: 10,
                ),
                /*ElevatedButton(
                  onPressed: onPressed,
                  child: Text(('Scan now')),
                ),*/


                SizedBox(
                  height: 10,
                ),
                Align(alignment: Alignment.topLeft, child: Text('The Content' , style: TextStyle( fontSize: 23 , fontWeight: FontWeight.bold),)),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async{
                      //buildQrView(context);
                     // Positioned(bottom: 10 , child: buildResult());


                   /* _pickedImage = imageFile;
                    _extractText =
                    await FlutterTesseractOcr.extractText(_pickedImage.path);*/
                  },
                  child: Text('Get Qr code'),
                ),

                Material(
                  elevation:  3.0,
                  shadowColor: Colors.grey,

                  borderRadius: BorderRadius.circular(15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),

                    child: Container(



                    // بدايه الانبوت
                      child: TextFormField(
                       // barcode != null ? 'Result : ${barcode!.code}': 'Scan the Code',
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

 /* Widget buildResult()  => Text(
    barcode != null ? 'Result : ${barcode!.code}': 'Scan the Code',
    maxLines: 3,
  );


  Widget buildQrView(BuildContext context) => QRView(
    key: qrKey,
    onQRViewCreated: onQRViewCreated,
  );

  void onQRViewCreated(QRViewController controller){
    setState(() => this.controller = controller);
    controller.scannedDataStream
        .listen((barcode) => setState(() => this.barcode = barcode));
  }*/

}
