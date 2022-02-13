import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constant_colors.dart';

const kAnimationDuration = Duration(milliseconds: 200);

// Padding cardMainPage(
//     BuildContext context, String str, Widget goto, Image image) {
//   return Padding(
//     padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
//     child: Card(
//       color: yellow,
//       shape: rectangleBorder(),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             InkWell(
//               onTap: () {
//                 Navigator.of(context).pop();
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => goto),
//                 );
//               },
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 decoration: boxDecoration(),
//                 child: ListTile(
//                   leading: image,
//                   trailing:
//                       const Icon(Icons.arrow_forward_ios, color: Colors.white),
//                   title: Text(
//                     str,
//                     style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 25,
//                         fontWeight: FontWeight.bold,
//                         letterSpacing: 1),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }

Widget getBottomSheet(
    String name, String mail, String description, double lat, double long) {
  return Stack(
    children: <Widget>[
      Container(
        margin: const EdgeInsets.only(top: 32),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.blueAccent,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: const <Widget>[
                        Text("4.5",
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text("970 Folowers",
                            style: TextStyle(color: Colors.white, fontSize: 14))
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(description,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14)),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                const SizedBox(
                  width: 20,
                ),
                const Icon(
                  Icons.map,
                  color: Colors.blue,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(lat.toString() + ',' + long.toString())
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: const <Widget>[
                SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: 20,
                ),
                Text("040-123456")
              ],
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.topRight,
          child: FloatingActionButton(
              child: const Icon(Icons.navigation),
              onPressed: () {
                navigateTo(lat, long);
              }),
        ),
      )
    ],
  );
}

void navigateTo(double lat, double lng) async {
  var uri = Uri.parse("https://maps.google.com/?q=$lat,$lng&mode=d");
  if (await canLaunch(uri.toString())) {
    await launch(uri.toString());
  } else {
    throw 'Could not launch ${uri.toString()}';
  }
}

Padding textHomePage(BuildContext context, String str, double size,
    FontWeight fontWeight, double height, TextAlign textAlign, Color color) {
  return Padding(
    padding: const EdgeInsets.only(left: 32, right: 32),
    child: Text(
      str,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: size,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: 1,
        height: height,
      ),
    ),
  );
}

InputDecoration secoundaryInputDecoration(
    BuildContext context, String str, IconButton iconSuffix, Icon iconPrefix) {
  return InputDecoration(
    hintText: str,
    hintStyle: const TextStyle(
      color: black,
      fontSize: 17,
      fontWeight: FontWeight.bold,
      letterSpacing: 1,
    ),
    errorStyle: const TextStyle(
      color: Colors.red,
      fontWeight: FontWeight.bold,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: blue),
      borderRadius: textBorderRadius,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: blue),
      borderRadius: textBorderRadius,
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red),
      borderRadius: textBorderRadius,
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red),
      borderRadius: textBorderRadius,
    ),
    suffixIcon: iconSuffix,
    prefixIcon: iconPrefix,
    border: OutlineInputBorder(
      borderRadius: textBorderRadius,
      borderSide: const BorderSide(
        width: 0,
        style: BorderStyle.none,
      ),
    ),
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  );
}

InputDecoration secoundaryInputDecoration2(
    BuildContext context, String Str, IconButton IconSuffix, Icon IconPrefix) {
  return InputDecoration(
    hintText: "$Str",
    hintStyle: const TextStyle(
      color: blue,
      fontSize: 17,
      fontWeight: FontWeight.bold,
      letterSpacing: 1,
    ),
    errorStyle: const TextStyle(
      color: Colors.red,
      fontWeight: FontWeight.bold,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: blue),
      borderRadius: textBorderRadius,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: blue),
      borderRadius: textBorderRadius,
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red),
      borderRadius: textBorderRadius,
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red),
      borderRadius: textBorderRadius,
    ),
    suffixIcon: IconSuffix,
    prefixIcon: IconPrefix,
    border: OutlineInputBorder(
      borderRadius: textBorderRadius,
      borderSide: const BorderSide(
        width: 0,
        style: BorderStyle.none,
      ),
    ),
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
  );
}

Container submit(BuildContext context, String str, Color color) {
  return Container(
    width: MediaQuery.of(context).size.width,
    decoration: boxDecoration(color),
    child: Padding(
      padding: const EdgeInsets.only(top: 13.0, bottom: 8.0),
      child: Text(
        "$str",
        style: const TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Padding textFormFiledHomePage(
    BuildContext context,
    var _key,
    var crl,
    String str,
    String error,
    Icon icons,
    IconButton iconButton,
    TextInputType textInputType,
    bool _passwordVisible) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20),
    child: Form(
      key: _key,
      child: TextFormField(
        style: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        cursorColor: Colors.white,
        strutStyle: const StrutStyle(
          fontSize: 20.0,
        ),
        controller: crl,
        validator: (val) {
          if (val.isEmpty) {
            return "$error";
          }
          return null;
        },
        decoration: inputDecorationHomePage(
          context,
          "$str",
          iconButton,
          icons,
        ),
        keyboardType: textInputType,
        obscureText: _passwordVisible,
      ),
    ),
  );
}

final textBorderRadius = BorderRadius.circular(10);

InputDecoration inputDecorationHomePage(
    BuildContext context, String Str, IconButton IconSuffix, Icon IconPrefix) {
  return InputDecoration(
    labelText: "$Str",
    labelStyle: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      letterSpacing: 1,
      fontSize: 17.0,
    ),
    errorStyle: const TextStyle(
      color: Colors.red,
      fontWeight: FontWeight.bold,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: blue, width: 1.5),
      borderRadius: textBorderRadius,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: blue, width: 1.5),
      borderRadius: textBorderRadius,
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red),
      borderRadius: textBorderRadius,
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red),
      borderRadius: textBorderRadius,
    ),
    suffixIcon: IconSuffix,
    prefixIcon: IconPrefix,
    border: OutlineInputBorder(
      borderRadius: textBorderRadius,
      borderSide: const BorderSide(
        width: 0,
        style: BorderStyle.none,
      ),
    ),
    filled: true,
    fillColor: yellow,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
  );
}

RoundedRectangleBorder rectangleBorder() {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  );
}

BoxDecoration boxDecoration(Color color) {
  return BoxDecoration(color: color, borderRadius: BorderRadius.circular(10.0));
}

SizedBox sizedBoxHomePage(double height) {
  return SizedBox(
    height: height,
  );
}

AwesomeDialog awesome(String title, BuildContext context) {
  return AwesomeDialog(
    dialogBackgroundColor: yellow,
    context: context,
    headerAnimationLoop: true,
    dialogType: DialogType.ERROR,
    body: Text(
      title,
      style: const TextStyle(
          color: yellow, fontWeight: FontWeight.bold, fontSize: 30),
    ),
    autoHide: const Duration(seconds: 7),
  )..show();
}
