import 'dart:convert';
import 'dart:io';
import 'package:educatednearby/constant/constant_colors.dart';
import 'package:educatednearby/constant/urls.dart';
import 'package:educatednearby/models/cvs.dart';
import 'package:educatednearby/services/updates.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

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
  List<Cvs> cvs = [];
  final imagePicker = ImagePicker();
  // int id = sharedPreferences.getInt("userID");

  Future getImage(ImageSource src) async {
    final pickedFile = await imagePicker.pickImage(source: src);

    setState(() {
      if (pickedFile != null) {
        images = File(pickedFile.path);
      } else {}
    });
  }

  Future<List<Cvs>> getCV() async {
    String url =
        'http://192.248.144.136/api/getCv.php?id=' + widget.id.toString();

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<Cvs> cvList = cvsFromJson(response.body);
        return cvList;
      } else {
        // ignore: deprecated_member_use
        return List<Cvs>();
      }
    } catch (x) {
      print(x);
    }
  }

  @override
  void initState() {
    super.initState();
    getCV().then((cvList) {
      setState(() {
        cvs = cvList;
        print(cvs);
      });
    });
    // print(natApi);
  }

  @override
  void dispose() {
    super.dispose();
    imageCache.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[500],
      appBar: AppBar(
        backgroundColor: yellow,
        title: const Text("Cirtifications"),
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
                      image: pic(),
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
                              bottomSheetNatID("National ID")),
                        );
                      },
                      child: const Text(
                        "Attach National ID",
                        style: TextStyle(color: yellow),
                      ))),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
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
                      children: const [
                        Icon(
                          Icons.description,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Upload CV",
                          style: TextStyle(
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
                ? cvs.length == 0
                    ? const Text(
                        "Please Add Put file",
                        style: TextStyle(color: yellow),
                      )
                    : cvs[0].resume != null
                        ? Text(cvs[0].resume)
                        : const Text("Please Add Put file")
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
                          child: Text("Save".toUpperCase(),
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
              label: const Text("Gallery",
                  style: TextStyle(
                    fontFamily: 'Simpletax',
                  )),
            ),
            FlatButton.icon(
              icon: const Icon(Icons.camera_alt),
              onPressed: () async {
                getImage(ImageSource.camera);
              },
              label: const Text("Camera",
                  style: TextStyle(
                    fontFamily: 'Simpletax',
                  )),
            ),
          ])
        ],
      ),
    );
  }

  ImageProvider pic() {
    if (images == null && cvs.isEmpty) {
      return const AssetImage("assets/images/userdefault.jpg");
    } else if (images != null) {
      return FileImage(File(images.path));
    } else if (cvs.isNotEmpty && cvs[0].identityPic != null) {
      return NetworkImage(Api.imagurl + cvs[0].identityPic);
    } else if (cvs[0].identityPic == null) {
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
          const Text(
            "Choose your CV",
            style: TextStyle(
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
              label: const Text("Files",
                  style: TextStyle(
                    fontFamily: 'Simpletax',
                  )),
            ),
          ])
        ],
      ),
    );
  }
}
