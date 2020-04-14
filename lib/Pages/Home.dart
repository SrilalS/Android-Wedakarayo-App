import 'dart:convert';
import 'dart:ui';
import 'package:awapp/Styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var postsList;
  var postslength = 0;
  var txt = [];
  var titles = [];
  var img = [];
  int postamount = 0;

  void mainStream(int post) async {
    var response = await http.get(
        'https://androidwedakarayo.com/ghost/api/v3/content/posts?key=8aff8bccef419606356a20bf70&limit=1&page=${post.toString()}');
    if (response.statusCode == 200) {
      var posts = jsonDecode(response.body);
      setState(() {
        postslength = posts['meta']['pagination']['pages'];
        print(postamount);
        titles.add(posts['posts'][0]['title']);
        txt.add(posts['posts'][0]['html']);
        img.add(posts['posts'][0]['feature_image']);
      });
      postsList = posts;
    }
    postamount += 1;
    if (post < postslength) {
      mainStream(post + 1);
    }
  }

  @override
  void initState() {
    super.initState();
    mainStream(1);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent));
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[700],
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                height: h * 0.89,
                width: w * 1,
                child: ListView.builder(
                    itemCount: postamount,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(8),
                        width: w * 0.9,
                        child: InkWell(
                          splashColor: Colors.green[900],
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {},
                          child: Card(
                            elevation: 8,
                            shape: rounded(16.0),
                            child: Column(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(16),
                                    topLeft: Radius.circular(16),
                                  ),
                                  child: Image.network(
                                    img[index].toString(),
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes
                                              : null,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(4),
                                  padding: EdgeInsets.all(4),
                                  child: Text(
                                    titles[index],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
