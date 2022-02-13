import 'dart:convert';
import 'dart:io';
import 'package:educatednearby/constant/constant_colors.dart';
import 'package:educatednearby/constant/urls.dart';
import 'package:educatednearby/package/applocal.dart';
import 'package:educatednearby/services/updates.dart';
import 'package:educatednearby/view_model/cv_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/src/provider.dart';

import '../main.dart';

class Certifications extends StatefulWidget {
  final int id;
  const Certifications({Key key, this.id}) : super(key: key);

  @override
  _CertificationsState createState() => _CertificationsState();
}

class _CertificationsState extends State<Certifications> {
  File file;
  File images;
  String cv;
  String cvpath;
  String image;
  String natApi;
  String cvApi;
  String descApi;
  final imagePicker = ImagePicker();
  var lang = sharedPreferences.getString("lang");
  // int id = sharedPreferences.getInt("userID");

  Future getImage(ImageSource src) async {
    final pickedFile = await imagePicker.pickImage(source: src);

    setState(() {
      if (pickedFile != null) {
        images = File(pickedFile.path);
      } else {}
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    imageCache.clear();
  }

  @override
  Widget build(BuildContext context) {
    CvViewModel cvViewModel = context.watch<CvViewModel>();
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: yellow,
        title: Text(getLang(context, "Cirtifications")),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.20,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: pic(cvViewModel),
                      fit: BoxFit.cover,
                      alignment: Alignment.center)),
            ),
            Builder(
              builder: (context) => Center(
                  child: TextButton(
                      onPressed: () async {
                        if (images != null) {
                          image = images.path.split('/').last;
                        }
                        showModalBottomSheet(
                          context: context,
                          builder: ((builder) =>
                              bottomSheetNatID(getLang(context, "NationalID"))),
                        );
                      },
                      child: Text(
                        getLang(context, "AttachNationalID"),
                        style: const TextStyle(color: yellow),
                      ))),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: lang == 'ar' ? 180 : 130,
                  child: RaisedButton(
                    onPressed: () {
                      setState(() {
                        showModalBottomSheet(
                          context: context,
                          builder: ((builder) => bottomSheetCV()),
                        );
                      });
                    },
                    color: yellow,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.description,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          getLang(context, "UploadCV"),
                          style: const TextStyle(
                              color: Colors.white, fontFamily: 'Simpletax'),
                        ),
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            cvpath == null
                ? cvViewModel.cv.length == 0
                    ? Text(
                        getLang(context, "PleaseAddPutfile"),
                        style: TextStyle(color: yellow),
                      )
                    : cvViewModel.cv[0].resume != null
                        ? Text(
                            cvViewModel.cv[0].resume,
                            style: const TextStyle(color: yellow),
                          )
                        : Text(getLang(context, "PleaseAddPutfile"))
                : Text(cvpath),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: TextButton(
                          child: Text(getLang(context, "Save"),
                              style: const TextStyle(fontSize: 14)),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(15)),
                              foregroundColor:
                                  MaterialStateProperty.all<Color>(yellow),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(color: yellow)))),
                          onPressed: () async {
                            if (images != null && cvpath != null) {
                              var now = DateTime.now();
                              image = widget.id.toString() +
                                  now.millisecond.toString() +
                                  '.' +
                                  images.path.split('.').last;
                              // print(image);
                              String imageDecode =
                                  base64Encode(images.readAsBytesSync());
                              await CV(widget.id, cvpath, cv, image,
                                  imageDecode, context);
                            } else if (images != null && cvpath == null) {
                              var now = DateTime.now();
                              image = widget.id.toString() +
                                  now.millisecond.toString() +
                                  '.' +
                                  images.path.split('.').last;
                              String imageDecode =
                                  base64Encode(images.readAsBytesSync());
                              await national(
                                  widget.id, image, imageDecode, context);
                            } else if (images == null && cvpath != null) {
                              await cvOnly(widget.id, cvpath, cv, context);
                            }
                          }),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget bottomSheetNatID(String text) {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            text,
            style: const TextStyle(
              fontSize: 20.0,
              fontFamily: 'Simpletax',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: const Icon(Icons.photo),
              onPressed: () async {
                getImage(ImageSource.gallery);
              },
              label: Text(getLang(context, "Gallery"),
                  style: const TextStyle(
                    fontFamily: 'Simpletax',
                  )),
            ),
            FlatButton.icon(
              icon: const Icon(Icons.camera_alt),
              onPressed: () async {
                getImage(ImageSource.camera);
              },
              label: Text(getLang(context, "Camera"),
                  style: const TextStyle(
                    fontFamily: 'Simpletax',
                  )),
            ),
          ])
        ],
      ),
    );
  }

  ImageProvider pic(CvViewModel cvViewModel) {
    if (images == null && cvViewModel.cv.isEmpty) {
      return const AssetImage("assets/images/userdefault.jpg");
    } else if (images != null) {
      return FileImage(File(images.path));
    } else if (cvViewModel.cv.isNotEmpty &&
        cvViewModel.cv[0].identityPic != null) {
      return NetworkImage(Api.imagurl + cvViewModel.cv[0].identityPic);
    } else if (cvViewModel.cv[0].identityPic == null) {
      return const AssetImage("assets/images/userdefault.jpg");
    } else {
      return const AssetImage("assets/images/userdefault.jpg");
    }
  }

  Widget bottomSheetCV() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            getLang(context, "ChooseyourCV"),
            style: const TextStyle(
              fontSize: 20.0,
              fontFamily: 'Simpletax',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: const Icon(Icons.file_copy),
              onPressed: () async {
                final result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: [
                      'pdf',
                      'word',
                    ],
                    allowMultiple: false);

                if (result == null) return;
                final path = result.files.single.path;
                setState(() => file = File(path));
                cv = base64Encode(file.readAsBytesSync());
                cvpath = file.path.split("/").last;
                Navigator.pop(context);
              },
              label: Text(getLang(context, "Files"),
                  style: const TextStyle(
                    fontFamily: 'Simpletax',
                  )),
            ),
          ])
        ],
      ),
    );
  }
}
