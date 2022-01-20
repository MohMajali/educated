import 'package:educatednearby/constant/components.dart';
import 'package:educatednearby/constant/constant_colors.dart';
import 'package:educatednearby/constant/urls.dart';
import 'package:educatednearby/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleServiceScreen extends StatefulWidget {
  final int id;
  final String nameEn;
  final String nameAr;
  final String logo;
  final String email;
  final String descEn;
  final String descAr;
  final String phone;
  final double lat;
  final double long;
  final String street;
  final String cv;

  const SingleServiceScreen(
      {Key key,
      this.id,
      this.nameEn,
      this.nameAr,
      this.logo,
      this.email,
      this.descEn,
      this.descAr,
      this.phone,
      this.lat,
      this.long,
      this.street,
      this.cv})
      : super(key: key);

  @override
  _SingleServiceScreenState createState() => _SingleServiceScreenState();
}

class _SingleServiceScreenState extends State<SingleServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      appBar: AppBar(
        backgroundColor: yellow,
        title: Text(
          widget.nameEn ?? "test",
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context,true);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.20,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: widget.logo == null
                      ? const NetworkImage(
                          "https://www.rei.com/dam/winter_camping_checklist_hero_lg.jpg")
                      : NetworkImage(Api.imagurl + widget.logo)),
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: TextFieldWidget(
              label: 'Store Name',
              text: widget.nameEn ?? "test1",
              onChanged: (store) {},
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: TextFieldWidget(
              label: 'Email',
              text: widget.email ?? "test2",
              onChanged: (email) {},
            ),
          ),
          const SizedBox(height: 15),
          InkWell(
            onTap: () {
              launch("tel:+96207" + widget.phone);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextFieldWidget(
                label: 'Phone',
                text: widget.phone.toString() ?? "test 3",
                maxLines: 5,
                onChanged: (phone) {},
              ),
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: TextFieldWidget(
              label: 'About',
              text: widget.descEn ?? "test4",
              maxLines: 5,
              onChanged: (desc) {},
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: TextFieldWidget(
              label: 'Address',
              text: widget.street ?? "No Address given",
              maxLines: 5,
              onChanged: (desc) {},
            ),
          ),
          const SizedBox(height: 15),
          InkWell(
            onTap: (){
              launch("http://192.248.144.136/userImage/"+widget.cv);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextFieldWidget(
                label: 'CV',
                text: widget.cv ?? "No CV attached",
                maxLines: 5,
                onChanged: (desc) {},
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: yellow,
        child: const Icon(
          Icons.navigation,
          color: Colors.white,
        ),
        onPressed: () {
          navigateTo(widget.lat, widget.long);
        },
      ),
    );
  }

  // _callNumber(String phone) async {
  //   //set the number here
  //   bool res = await FlutterPhoneDirectCaller.callNumber(phone);
  // }
}
