import 'dart:io';
import 'package:flutter/material.dart';

import 'package:easy_localization/src/public_ext.dart';
import 'package:tflite/tflite.dart';
import 'package:flutter_tts/flutter_tts.dart';



class convertTrafficTo extends StatefulWidget {

  final File imageFile;
  final String text, imageIcon;
  final Color colorBar;

  const convertTrafficTo(
      {Key? key,

        required this.imageFile,
        required this.text,
        required this.imageIcon,
        required this.colorBar})
      : super(key: key);

  @override
  State<convertTrafficTo> createState() => _convertTrafficToState();

}

class _convertTrafficToState extends State<convertTrafficTo> {
  List? _outputs;
  File? _image;
  bool _loading = false;
  var _statueData;

  @override
  void initState() {
    super.initState();


    loadModel().then((value) {
      setState(() {
      });
    });
  }

  final TextEditingController controller = TextEditingController();
  final FlutterTts flutterTts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var hight = MediaQuery.of(context).size.height;

    Future _speak() async {
      await flutterTts.setLanguage("en-US");
      await flutterTts.setPitch(1);
      await flutterTts.speak(_outputs![0]["label"]);
    }

    Future _speakMultipleLang() async {
      await flutterTts.setLanguage("ja-JP");
      await flutterTts.setPitch(1);
      await flutterTts.speak(_outputs![0]["label"]);
    }

    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: widget.colorBar,
          leading: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Image.asset(
              widget.imageIcon,
            ),
          ),
          title: Text(
            widget.text,
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
          actions: [],
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
                Center(
                    child: Image.file(
                      widget.imageFile,
                      width: width * 0.6,
                    )),
                SizedBox(
                  height: 10,
                ),
                Align(

                    child: Text(
                      'Description'.tr(),
                      style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: ()
                  {
                    final imageTemporary = File(widget.imageFile.path);
                    classifyImage(imageTemporary);
                    /* // getImagefromcamera();
                    // getImagefromGallery();

                  // setState(() {
                  //   controller.text = _outputs![0]["label"];
                  // });*/


                  },
                  child: const Text('Check').tr(),
                  style: ElevatedButton.styleFrom(

                    onPrimary: Colors.white,
                    elevation: 10,
                  ),
                ),

                Material(
                  elevation: 3.0,
                  shadowColor: Colors.grey,
                  borderRadius: BorderRadius.circular(15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      child: TextFormField(
                        controller: controller,
                        maxLines: 4,
                        onTap: () {},
                        cursorColor: Colors.black,
                        showCursor: true,
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          suffixIcon: IconButton(
                            onPressed: () => _speak(),
                            icon: Icon(
                              Icons.headset,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
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

  Future getImagefromcamera() async {
    final imageTemporary = File(widget.imageFile.path);
    setState(() {
      _loading = true;
      _image = imageTemporary;
    });
    classifyImage(imageTemporary);
  }

  Future getImagefromGallery() async {
    final imageTemporary = File(widget.imageFile.path);

    setState(() {
      _loading = true;
      _image = imageTemporary;
    });
    classifyImage(imageTemporary);
  }

  classifyImage(File image) async {

    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    _outputs = output!;

    print(_outputs);
    setState(() {
      _loading = false;
      _outputs = output;
      controller.text = _outputs![0]["label"];
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/yourmodel.tflite",
      labels: "assets/labels.txt",
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}

