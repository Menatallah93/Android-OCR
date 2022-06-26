import 'dart:io';

//import 'package:androidocr/src/lang.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:settings_ui/settings_ui.dart";
import 'package:url_launcher/url_launcher.dart';


class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool lockInBackground = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'.tr()),
        backgroundColor: Color.fromARGB(255, 4, 0, 52),
      ),

      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('Common'.tr()),
            tiles: [
              SettingsTile(
                title: Text('Language'.tr()),
                // subtitle: 'English',
                leading: Icon(Icons.language),
                onPressed: (_) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title:  Text("Choose Language".tr()),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              context.setLocale(const Locale('ar'));
                            },
                            child: const Text("عربي"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              context.setLocale(const Locale('en'));
                            },
                            child: const Text("English"),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          SettingsSection(
            title: Text('Account'.tr()),
            tiles: [
              SettingsTile(
                title: Text('Phone Number'.tr()),
                leading: Icon(
                  Icons.phone,
                  color: Colors.black54,
                ),
                onPressed: (_) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>  AlertDialog(
                      title: Text('Phone Number'.tr()),
                      content: Text("+201589675204"),
                    ),
                  );
                },
              ),
              SettingsTile(
                  title: Text('Email'.tr()),
                  leading: Icon(
                    Icons.email,
                    color: Colors.black,
                  ),
                    onPressed: (_) {
                    showDialog(
                    context: context,
                    builder: (BuildContext context) =>  AlertDialog(
                    title: Text("Email".tr()),
                    content: Text("androi.ocr22@gmail.com"),
                    ),
                    );
                    },
              ),
              SettingsTile(
                  title: Text('Facebook'.tr()),
                  leading: Icon(
                    Icons.facebook,
                    color: Colors.blue,
                  ),
                onPressed: (_) async {
                    final url = 'https://m.facebook.com/Android-Ocr_ProScan-107632361963554/';
                    if (await canLaunch(url)){
                      await launch(url);
                    }
                },
              ),

            ],
          ),
          SettingsSection(
            title: Text('About'.tr()),
            tiles: [
              SettingsTile(
                  title: Text('information'.tr()),
                  leading: Icon(Icons.description),

                  onPressed: (_) {
                  showDialog(
                  context: context,
                  builder: (BuildContext context) =>  AlertDialog(
                  title: Text("information".tr()),
                  content: Text("Optical character recognition or optical character reader (OCR) is the electronic or mechanical conversion of images of typed,"
                      " handwritten or printed text into machine-encoded text, whether from a scanned document, a photo of a document, a scene-photo "
                      "(for example the text on signs and billboards in a landscape photo) or from subtitle text superimposed on an image").tr(),
                  ),
                  );
                  },
              ),
            ],
          )
        ],
      ),
    );
  }
}
