import 'dart:io';

import 'package:androidocr/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

//import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:easy_localization/src/public_ext.dart';

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
  final _QrTextController = TextEditingController();

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
                Align(/*alignment: Alignment.topLeft,*/
                    child: Text('The Content'.tr() , style: TextStyle( fontSize: 23 , fontWeight: FontWeight.bold),)),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async{

                    final barcodeScanner = GoogleMlKit.vision.barcodeScanner();
                    var image = InputImage.fromFile(widget.imageFile);
                    final List<Barcode> barcodes = await barcodeScanner.processImage(image);

                    for (Barcode barcode in barcodes) {
                      final BarcodeType type = barcode.type;
                      // See API reference for complete list of supported types
                      switch (type) {
                        case BarcodeType.wifi:
                          BarcodeValue barcodeWifi = barcode.value;
                          _QrTextController.text = barcodeWifi.displayValue??"";
                          break;
                        case BarcodeType.url:
                          BarcodeValue barcodeUrl = barcode.value;
                          _QrTextController.text = barcodeUrl.displayValue??"";
                          break;
                        default:
                          BarcodeValue barcodeDefault = barcode.value;
                          _QrTextController.text = barcodeDefault.displayValue??"";
                      }
                    }
                    print(_QrTextController.text);

                  },
                  child: Text('Get Qr code'.tr()),
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
                        controller: _QrTextController,
                        maxLines: 4,
                        onTap: () {
                          print('g');
                        },
                        // textAlign: TextAlign.,
                        cursorColor: Colors.black,
                        showCursor: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          // suffixIcon: IconButton(
                          //   onPressed: () => _speak(),
                          //   icon: Icon(
                          //     Icons.headset,
                          //     color: Colors.black,
                          //     size: 30,
                          //   ),
                          // ),
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

              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
