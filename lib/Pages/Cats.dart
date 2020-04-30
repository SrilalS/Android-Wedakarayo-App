import 'package:awapp/Services/CatGetter.dart';
import 'package:flutter/material.dart';

class Cats extends StatefulWidget {
  @override
  _CatsState createState() => _CatsState();
}

class _CatsState extends State<Cats> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    catStreamMaker();
  }

  void stMgr() {}

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Container(
          height: h,
          width: w * 0.9,
          child: StreamBuilder(
              stream: catStreamMaker().asStream(),
              builder: (context, tags) {
                if (taglist.length < 1) {
                  return Column(
                    children: <Widget>[
                      LinearProgressIndicator(
                        backgroundColor: Colors.green,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ],
                  );
                }
                return ListView.builder(
                    itemCount: taglist.length,
                    itemBuilder: (context, index) {
                      if (taglist.length < 1) {
                        return LinearProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        );
                      }
                      return Card(
                        child: InkWell(
                          splashColor: Colors.green,
                          onTap: () {},
                          child: ListTile(
                            title: Text(taglist[index]),
                          ),
                        ),
                      );
                    });
              }),
        ),
      ),
    );
  }
}
