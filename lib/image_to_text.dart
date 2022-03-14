import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:translator/translator.dart';
import 'package:flutter_tts/flutter_tts.dart';


class convertImageTo extends StatefulWidget{

  final File imageFile;
  final String text , imageIcon;
  final Color colorBar;
  const convertImageTo({Key? key, required this.imageFile , required this.text , required this.imageIcon , required this.colorBar}) : super(key: key);

  @override
  State<convertImageTo> createState() => _convertImageToState();
}

class _convertImageToState extends State<convertImageTo> {
  String _extractText = '';
  bool flag = false;
  //File? _pickedImage;


  final FlutterTts flutterTts = FlutterTts();


  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = new TextEditingController();


    var width=MediaQuery.of(context).size.width;
    var hight=MediaQuery.of(context).size.height;
    var _numbers = [
      'Arabic',
      'English',


    ]
        .asMap()
        .entries
        .map((entry) => MultiSelectItem<dynamic>(entry.key, entry.value))
        .toList();

    Future _speak() async{
      await flutterTts.setLanguage("en-US");
      await flutterTts.setPitch(1);
      await flutterTts.speak(_extractText);
    }

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
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Center(child: Image.file(widget.imageFile , width: width * 0.6  ,)),
                SizedBox(
                  height: 10,
                ),


                ElevatedButton(
                  onPressed: () async{
                    setState(() {
                      flag = true;
                    });
                    String path = widget.imageFile.path.toString();//Image.file(widget.imageFile).image.toString();

                    final inputImage = InputImage.fromFile(widget.imageFile);
                    final textDetector = GoogleMlKit.vision.textDetector();
                    final RecognisedText recognisedText = await textDetector.processImage(inputImage);
                    String text = recognisedText.text;

                    // for (TextBlock block in recognisedText.blocks) {
                    //   final Rect rect = block.rect;
                    //   final List<Offset> cornerPoints = block.cornerPoints;
                    //   final String text = block.text;
                    //   final List<String> languages = block.recognizedLanguages;
                    //
                    //   for (TextLine line in block.lines) {
                    //     // Same getters as TextBlock
                    //     for (TextElement element in line.elements) {
                    //       // Same getters as TextBlock
                    //     }
                    //   }
                    // }
                    textDetector.close();
                    print(text);
                    _extractText = text;

                    setState(() {
                      flag = false;
                    });
                  },
                  child: Text('Convert To Text'),
                ),
                SizedBox(height: 20),
                flag
                    ? Center(child: CircularProgressIndicator())
                // : Center(
                //   child: Text(
                //     _extractText,
                //     style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,),
                //   ),
                // ),

                    : Material(
                  elevation: 3.0,
                  shadowColor: Colors.grey,

                  borderRadius: BorderRadius.circular(15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(

                      child: TextFormField(
                        maxLines: 4,
                        cursorColor: Colors.black,
                        showCursor: true,
                        //_extractText,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.fromLTRB(20, 5, 5, 5),
                          suffixIcon: IconButton(
                            onPressed: () => _speak(),
                            icon: Icon(Icons.headset, color: Colors.black, size: 30,),
                          ),
                          // child: RaisedButton(
                          //   child: Icon(Icons.headset, color: Colors.black, size: 30,),
                          //     onPressed: () => _speak(),
                          // ),
                        ),
                        initialValue: _extractText,
                      ),

                      /*child: Center(
                          child: Text(
                            _extractText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),*/

                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),


                Row(
                  children: [
                    Expanded(flex: 2, child: Text("Translate")),
                    //SizedBox(width:  width*0.1,),
                    Expanded(
                      flex: 3,
                      child: Material(
                          elevation: 2,
                          shadowColor: Colors.grey,
                          borderRadius: BorderRadius.circular(15),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Container(

                                  color: Colors.white,
                                  child: MultiSelectDialogField(

                                    items: _numbers,
                                    chipDisplay: MultiSelectChipDisplay(

                                      chipColor: Colors.black26,
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14),
                                    ),
                                    //decoration: BoxDecoration(),
                                    title: Text("Language"),

                                    selectedColor: Colors.black,
                                    onConfirm: (value) {},
                                    // DropdownButton<String>(
                                    //   value: dropdownValue,
                                    //   isExpanded: true,
                                    //   icon: Icon(
                                    //     Icons.arrow_downward,
                                    //   ),
                                    //   iconSize: 24,
                                    //   dropdownColor: Colors.white,
                                    //   style: TextStyle(color: Colors.black),
                                    //   underline: Container(
                                    //     height: 2,
                                    //     width: double.infinity,
                                    //   ),
                                    //   onChanged: (String? newValue) {
                                    //     setState(() {
                                    //       dropdownValue = newValue!;
                                    //     });
                                    //   },
                                    //   items: <String>[
                                    //     'One',
                                    //     'Two',
                                    //     'Free',
                                    //     'Four'
                                    //   ].map<DropdownMenuItem<String>>(
                                    //       (String value) {
                                    //     return DropdownMenuItem<String>(
                                    //       value: value,
                                    //       child: Text(value),
                                    //     );
                                    //   }).toList(),
                                    // ),
                                  )))),
                    ),
                  ],
                ),

                SizedBox(
                  height: 10,
                ),
                Material(
                  elevation: 3.0,
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
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          suffixIcon: IconButton(
                            onPressed: () => _speak(),
                            icon: Icon(Icons.headset, color: Colors.black, size: 30,),
                          ),

                        ),
                      ),
                    ),
                  ),
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





