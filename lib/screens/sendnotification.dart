import 'dart:convert';
import 'package:educatednearby/constant/components.dart';
import 'package:educatednearby/constant/constant_colors.dart';
import 'package:educatednearby/package/applocal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class sendNotificationScreen extends StatefulWidget {
  final int userId;
  const sendNotificationScreen({Key key, this.userId}) : super(key: key);

  @override
  _sendNotificationScreenState createState() => _sendNotificationScreenState();
}

class _sendNotificationScreenState extends State<sendNotificationScreen> {
  var serverToken =
      "AAAAbt2KXKY:APA91bFFHxJ4EjkJRWWVLB8f6wJry6IAQNLxG2UwQiUDOTSgit1sGZlI8VaCoI_1Gkq9o8RttqKlIiKE0SU9JI29NQbSw7MRZGvX5nq_5qllUJ3f2O_VQSkXSJXIzQyEQMftbiaZEUrj";

  final _keyTitle = GlobalKey<FormState>();
  final _keyBody = GlobalKey<FormState>();

  TextEditingController titleCrl = TextEditingController();
  TextEditingController bodyCrl = TextEditingController();

  sendNotify(int id, String title, String body, var userid) async {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': body.toString(),
            'title': title.toString(),
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': id,
            'status': 'done'
          },
          //الى من رح توصل الرساله

          'to': '/topics/' + userid.toString()
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(getLang(context, "EducatedNearby")),
        backgroundColor: yellow,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 32, right: 32),
            child: Form(
              key: _keyTitle,
              child: TextFormField(
                style: const TextStyle(
                  color: blue,
                ),
                cursorColor: blue,
                controller: titleCrl,
                keyboardType: TextInputType.text,
                validator: (val) {
                  if (val.isEmpty) {
                    return getLang(context, "FieldRequired");
                  }
                  return null;
                },
                decoration: secoundaryInputDecoration(
                    context, getLang(context, "title"), null, null),
              ),
            ),
          ),
          sizedBoxHomePage(10),
          Padding(
            padding: const EdgeInsets.only(left: 32, right: 32),
            child: Form(
              key: _keyBody,
              child: TextFormField(
                style: const TextStyle(
                  color: blue,
                ),
                cursorColor: blue,
                controller: bodyCrl,
                keyboardType: TextInputType.text,
                validator: (val) {
                  if (val.isEmpty) {
                    return getLang(context, "FieldRequired");
                  }
                  return null;
                },
                decoration: secoundaryInputDecoration(
                    context, getLang(context, "body"), null, null),
              ),
            ),
          ),
          sizedBoxHomePage(10),
          Padding(
            padding: const EdgeInsets.only(left: 32, right: 32),
            child: GestureDetector(
              onTap: () async {
                String title = titleCrl.text;
                String body = bodyCrl.text;
                if (_keyTitle.currentState.validate() &&
                    _keyBody.currentState.validate()) {
                  await sendNotify(2, title, body, widget.userId);
                } else {
                  // return print('object');
                }
              },
              child: submit(context, getLang(context, "SEND"), yellow),
            ),
          )
        ],
      ),
    );
  }
}
