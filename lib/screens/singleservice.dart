import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:educatednearby/constant/components.dart';
import 'package:educatednearby/constant/constant_colors.dart';
import 'package:educatednearby/constant/urls.dart';
import 'package:educatednearby/models/store.dart';
import 'package:educatednearby/package/applocal.dart';
import 'package:educatednearby/screens/videocall.dart';
import 'package:educatednearby/view_model/single_service_view.dart';
import 'package:educatednearby/widgets/textfield_widget.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';

class SingleServiceScreen extends StatefulWidget {
  final String id;
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
  final String serviceId;
  final List<Store> singleService;

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
      this.cv,
      this.serviceId,
      this.singleService})
      : super(key: key);

  @override
  _SingleServiceScreenState createState() => _SingleServiceScreenState();
}

class _SingleServiceScreenState extends State<SingleServiceScreen> {
  var lang = sharedPreferences.getString("lang");
  AppLinks _appLinks;
  final _navigatorKey = GlobalKey<NavigatorState>();
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  String deepname = sharedPreferences.getString("deep");

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // sharedPreferences.remove("deep");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SingleServiceModel singleServiceModel = context.read<SingleServiceModel>();
    if (widget.nameEn != null) {
      return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: yellow,
          title: lang == 'ar'
              ? Text(
                  widget.nameAr ?? "test",
                )
              : Text(
                  widget.nameEn ?? "test",
                ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VideoCallScreen()),
                  );
                },
                icon: const Icon(Icons.video_call)),
            IconButton(
                onPressed: () async {
                  await createLink(widget.serviceId);
                },
                icon: const Icon(Icons.share)),
            // IconButton(
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => sendNotificationScreen(
            //                   userId: widget.id,
            //                 )),
            //       );
            //     },
            //     icon: const Icon(Icons.notification_add)),
          ],
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
                label: getLang(context, "StoreName"),
                text: lang == 'ar'
                    ? widget.nameAr ?? getLang(context, "test1")
                    : widget.nameEn ?? getLang(context, "test1"),
                onChanged: (store) {},
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextFieldWidget(
                label: getLang(context, "Email"),
                text: widget.email ?? getLang(context, "test2"),
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
                  label: getLang(context, "phone"),
                  text: widget.phone.toString() ?? getLang(context, "test3"),
                  maxLines: 5,
                  onChanged: (phone) {},
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getLang(context, "About"),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: yellow,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Center(
                        child: lang == 'ar'
                            ? Text(
                                widget.descAr ?? getLang(context, "test4"),
                                style: const TextStyle(color: yellow),
                              )
                            : Text(widget.descEn ?? getLang(context, "test4"),
                                style: const TextStyle(color: yellow)),
                      ),
                    ),
                  ],
                )),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextFieldWidget(
                label: getLang(context, "Address"),
                text: widget.street ?? getLang(context, "NoAddressgiven"),
                maxLines: 5,
                onChanged: (desc) {},
              ),
            ),
            const SizedBox(height: 15),
            InkWell(
              onTap: () {
                widget.cv == null
                    ? null
                    : launch("http://192.248.144.136/userImage/" + widget.cv);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: TextFieldWidget(
                  label: getLang(context, "CV"),
                  text: widget.cv ?? getLang(context, "NoCVattached"),
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
    } else {
      return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: yellow,
          title: lang == 'ar'
              ? Text(
                  widget.nameAr ?? "test",
                )
              : Text(
                  widget.nameEn ?? "test",
                ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VideoCallScreen()),
                  );
                },
                icon: const Icon(Icons.video_call)),
            IconButton(
                onPressed: () async {
                  await createLink(widget.serviceId);
                },
                icon: const Icon(Icons.share)),
            // IconButton(
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => sendNotificationScreen(
            //                   userId: widget.id,
            //                 )),
            //       );
            //     },
            //     icon: const Icon(Icons.notification_add)),
          ],
        ),
        body: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: widget.singleService.length,
            itemBuilder: (_, i) {
              Store store = widget.singleService[i];
              if (widget.singleService.isEmpty) {
                return Center();
              } else {
                return Column(
                  children: [
                    const SizedBox(height: 24),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.20,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: store.logo == null
                              ? const NetworkImage(
                                  "https://www.rei.com/dam/winter_camping_checklist_hero_lg.jpg")
                              : CachedNetworkImage(
                                  imageUrl: Api.imagurl + store.logo,
                                  placeholder: (context, url) => Container(
                                      child: const Center(
                                          child: CircularProgressIndicator())),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: TextFieldWidget(
                        label: getLang(context, "StoreName"),
                        text: lang == 'ar'
                            ? store.nameAr ?? getLang(context, "test1")
                            : store.nameEn ?? getLang(context, "test1"),
                        onChanged: (store) {},
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: TextFieldWidget(
                        label: getLang(context, "Email"),
                        text: store.email ?? getLang(context, "test2"),
                        onChanged: (email) {},
                      ),
                    ),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () {
                        launch("tel:+96207" + store.phone);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: TextFieldWidget(
                          label: getLang(context, "phone"),
                          text: store.phone.toString() ??
                              getLang(context, "test3"),
                          maxLines: 5,
                          onChanged: (phone) {},
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getLang(context, "About"),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: yellow,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Center(
                                child: lang == 'ar'
                                    ? Text(
                                        store.descAr ??
                                            getLang(context, "test4"),
                                        style: const TextStyle(color: yellow),
                                      )
                                    : Text(
                                        store.descEn ??
                                            getLang(context, "test4"),
                                        style: const TextStyle(color: yellow)),
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: TextFieldWidget(
                        label: getLang(context, "Address"),
                        text:
                            widget.street ?? getLang(context, "NoAddressgiven"),
                        maxLines: 5,
                        onChanged: (desc) {},
                      ),
                    ),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () {
                        widget.cv == null
                            ? null
                            : launch("http://192.248.144.136/userImage/" +
                                store.resume);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: TextFieldWidget(
                          label: getLang(context, "CV"),
                          text:
                              store.resume ?? getLang(context, "NoCVattached"),
                          maxLines: 5,
                          onChanged: (desc) {},
                        ),
                      ),
                    ),
                  ],
                );
              }
            }),
      );
    }
  }

  Future<String> createLink(String id) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: 'https://educationnearby.page.link',
        link: Uri.parse(
            'https://educatednearby.com/SingleServiceScreen?serviceid=' + id),
        androidParameters:
            const AndroidParameters(packageName: 'education.com.nearby'));

    final Uri dynamic = await dynamicLinks.buildLink(parameters);
    Share.share(dynamic.toString());
    return dynamic.toString();
  }
}
