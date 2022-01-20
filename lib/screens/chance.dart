import 'package:educatednearby/constant/constant_colors.dart';
import 'package:educatednearby/models/chance.dart';
import 'package:educatednearby/view_model/chance_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import 'home_page.dart';

class ChanceScreen extends StatefulWidget {
  const ChanceScreen({Key key}) : super(key: key);
  @override
  _ChanceScreenState createState() => _ChanceScreenState();
}

class _ChanceScreenState extends State<ChanceScreen> {
  @override
  Widget build(BuildContext context) {
    ChanceViewModel chanceViewModel = context.watch<ChanceViewModel>();
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: const Text("FORSA"),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: _chanceUi(chanceViewModel),
        ));
  }

  _chanceUi(ChanceViewModel chanceViewModel) {
    if (chanceViewModel.loading) {
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: const Text("Loading"),
      );
    }

    return Container(
      color: Colors.grey[300],
      height: MediaQuery.of(context).size.height * 1.2,
      child: Stack(
        children: [
          Container(
            color: Colors.grey[300],
            width: double.infinity,
            height: double.infinity,
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 4,
                ),
                itemBuilder: (_, index) {
                  Chance chance = chanceViewModel.chance[index];
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey,
                            // offset: const Offset(3, 3),
                            blurRadius: 16,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16.0)),
                        child: Column(
                          children: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(
                                "https://www.rei.com/dam/winter_camping_checklist_hero_lg.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [],
                                    ),
                                    Center(
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          text: chance.nameEn,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          text: chance.descriptionEn,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20.0),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          primary: black,
                                          backgroundColor: blue,
                                        ),
                                        onPressed: () async {
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             Chanc()));
                                          // print(service.id);
                                        },
                                        child: const Text("View",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: null == chanceViewModel.chance
                    ? 0
                    : chanceViewModel.chance.length),
          ),
        ],
      ),
    );
  }
}
