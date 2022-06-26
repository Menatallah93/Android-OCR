import 'dart:convert';
import 'dart:io';

import 'package:androidocr/image_to_text.dart';

//import 'package:androidocr/setting.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

import 'QR.dart';
import 'constant.dart';
import 'doc.dart';
import 'math.dart';
import 'math.dart';
import 'traffic.dart';
import 'sett.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late File image;
  late int numPage;
  late String text;

  late String imageIcon;
  late Color colorBar;
  final List<String> imgList = [
    'assets/ocr1.jpeg',
    'assets/ocr2.jpg',
    'assets/ocr3.jpg',
    'assets/ocr4.jpg'
  ];

  //اما افتح اي واحده هيطلعلي اختار من الجاليري او نفتح الكاميرا
  _openGallary(BuildContext context) async {
    var pic = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    this.setState(() {
      image = File(pic!.path);
    });
    if (numPage == 1) {
      navigateTo(
          context,
          convertImageTo(
            imageFile: image,
            text: text,
            imageIcon: imageIcon,
            colorBar: colorBar,
          ));
    } else if (numPage == 2) {
      navigateTo(
          context,
          convertMathTo(
            imageFile: image,
            text: text,
            imageIcon: imageIcon,
            colorBar: colorBar,
          ));
    } else if (numPage == 3) {
      navigateTo(
          context,
          convertQRTo(
            imageFile: image,
            text: text,
            imageIcon: imageIcon,
            colorBar: colorBar,
          ));
    } else if (numPage == 4) {
      navigateTo(
          context,
          convertTrafficTo(
            imageFile: image,
            text: text,
            imageIcon: imageIcon,
            colorBar: colorBar,
          ));
    }
  }

  _openCamera(BuildContext context) async {
    var pic = await ImagePicker.platform.pickImage(source: ImageSource.camera);
    this.setState(() {
      image = File(pic!.path);
    });

    if (image != null) {
      if (numPage == 1) {
        navigateTo(
            context,
            convertImageTo(
              imageFile: image,
              text: text,
              imageIcon: imageIcon,
              colorBar: colorBar,
            ));
      } else if (numPage == 2) {
        navigateTo(
            context,
            convertMathTo(
              imageFile: image,
              text: text,
              imageIcon: imageIcon,
              colorBar: colorBar,
            ));
      } else if (numPage == 3) {
        navigateTo(
            context,
            convertQRTo(
              imageFile: image,
              text: text,
              imageIcon: imageIcon,
              colorBar: colorBar,
            ));
      } else if (numPage == 4) {
        navigateTo(
            context,
            convertTrafficTo(
              imageFile: image,
              text: text,
              imageIcon: imageIcon,
              colorBar: colorBar,
            ));
      }
    }
  }

  _openFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      String? file = result.files.single.path;
      String fileName = file!.split('/').last;
      String exten = p.extension(file);
      print("#################################3");
      print(file);
      new File(file)
          .openRead()
          .transform(utf8.decoder)
          .transform(new LineSplitter())
          .forEach((l) => print('line: $l'));
      navigateTo(
          context,
          convertDocTo(
            text: text,
            imageIcon: imageIcon,
            colorBar: colorBar,
            pathFile: file,
            nameFile: fileName,

            typeFile: exten,
          ));
    } else {
      print("#################################3");
      print("empty");
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var hight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: kColorPrimary,
          leading: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Image.asset(
              'assets/11.png',
            ),
          ),
          title: Row(
            children: [
              Text(
                'Pro',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              Text(
                'Scan',
                style: TextStyle(color: Colors.red, fontSize: 25),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              //child: Icon(Icons.settings),

              child: ElevatedButton(
                child: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => SettingsScreen()));
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 4, 0, 52),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: hight * .38,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                ),
                items: imgList
                    .map((item) => Container(
                          child: Center(
                              child: Image.asset(
                            item,
                            fit: BoxFit.cover,
                            height: hight * .38,
                          )),
                        ))
                    .toList(),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                child: Text(
                  'services'.tr(),
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buttonServices(
                      //icons
                      color: Color.fromARGB(255, 187, 222, 251),
                      //color: Color.fromRGBO( 187, 222, 251, 1) , opacity=1 for all colors
                      img: 'assets/ocr11.png',
                      text: ('Image To Text'.tr()),
                      width: width * .9,
                      openDialog: dialog,
                      numPage: 1,
                      colorBar: Color.fromARGB(255, 187, 222, 251),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buttonServices(
                      //color: Color.fromARGB(255, 255, 249, 196),
                      color: Color.fromARGB(255, 225, 232, 204),
                      img: 'assets/calculator.png',
                      text: ('Mathematical Equation'.tr()),
                      width: width * .9,
                      openDialog: dialog,
                      numPage: 2,
                      colorBar: Color.fromARGB(255, 225, 232, 204),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buttonServices(
                      color: Color.fromARGB(255, 178, 235, 242),
                      img: 'assets/qr.png',
                      text: ('QR Code'.tr()),
                      width: width * .9,
                      openDialog: dialog,
                      numPage: 3,
                      colorBar: Color.fromARGB(255, 178, 235, 242),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buttonServices(
                        color: Color.fromARGB(255, 197, 202, 233),
                        img: 'assets/sign.png',
                        text: ('Traffic Sign'.tr()),
                        width: width * .9,
                        openDialog: dialog,
                        numPage: 4,
                        colorBar: Color.fromARGB(255, 197, 202, 233))
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buttonServices(
                        color: Color.fromARGB(255, 201, 231, 227),
                        img: 'assets/document.png',
                        text: ('Document'.tr()),
                        width: width * .9,
                        openDialog: dialog,
                        numPage: 5,
                        colorBar: Color.fromARGB(255, 201, 231, 227))
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  dialog(int numPage, String text, String imageIcon, Color colorBar) {
    this.imageIcon = imageIcon;
    this.colorBar = colorBar;
    this.text = text;
    this.numPage = numPage;
    numPage != 5
        ? showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            backgroundColor: Colors.white,
            context: context,
            builder: (context) => Wrap(children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera').tr(),
                onTap: () async {
                  _openCamera(context);
                  //Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_album),
                title: Text('Gallery').tr(),
                onTap: () {
                  _openGallary(context);
                  //Navigator.pop(context);
                },
              ),
            ]),
          )
        : _openFile(context);
  }
}
