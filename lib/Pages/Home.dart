import 'dart:convert';
import 'dart:ui';
import 'package:awapp/Pages/Article.dart';
import 'package:awapp/Pages/Cats.dart';
import 'package:awapp/Pages/Keys.dart';
import 'package:awapp/Pages/Saved.dart';
import 'package:awapp/Pages/sign.dart';
import 'package:awapp/Services/Service.dart';
import 'package:awapp/Services/Userdta.dart';
import 'package:awapp/Styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final pgcontroller = PageController(initialPage: 0);
  int pageindex = 0;

  int btindex = 0;
  var postsList;
  var postslength = 0;
  var postid = [];
  var txt = [];
  var titles = [];
  var img = [];
  var authors = [];
  var dates = [];
  var links = [];
  int postamount = 0;
  String apikey = apiKey();

  //Reactions Colors and Stuff
  Color addbtn = Colors.green;
  Color lovebtn = Colors.green;
  var lovelist = [];

  //

  //SigninData
  var uname = 'Android වැඩකාරයෝ';
  var uid = '0';
  var uimage =
      'https://androidwedakarayo.com/content/images/2020/04/avatardef.jpg';
  var isloggedString = 'Login';
  var uemail = 'App V1.2';
  var logcolor = Colors.green;
  //

  void mainStream(int post) async {
    var response = await http.get(
        'https://androidwedakarayo.com/ghost/api/v3/content/posts?key=${apikey}&limit=1&page=${post.toString()}&include=authors');

    if (response.statusCode == 200) {
      var posts = jsonDecode(response.body);
      setState(() {
        postslength = posts['meta']['pagination']['pages'];
        print(postamount);
        titles.add(posts['posts'][0]['title']);
        txt.add(posts['posts'][0]['html']);
        img.add(posts['posts'][0]['feature_image']);
        authors.add(posts['posts'][0]['authors'][0]['name']);
        dates.add(posts['posts'][0]['published_at']);
        links.add(posts['posts'][0]['url']);
        postid.add(posts['posts'][0]['id']);
        lovelist.add(Colors.green);
      });
      postsList = posts;
    }
    postamount += 1;
    //TODO Remove the Post Limit
    if (post < postslength && post < 32) {
      mainStream(post + 1);
    } else {
      refreshController.loadComplete();
      refreshController.refreshCompleted();
    }
  }

  void signoffer() async {
    Navigator.pop(context);
    var udata = await handleSignIn();
    setState(() {
      isLogged = false;
      udata.delete();
      uname = 'Android වැඩකාරයෝ';
      uid = '0';
      uimage =
          'https://androidwedakarayo.com/content/images/2020/04/avatardef.jpg';
      isloggedString = 'Login';
      uemail = 'App V1.2';
      logcolor = Colors.green;
    });
  }

  void signiner() async {
    Navigator.pop(context);
    var udata = await handleSignIn();
    setState(() {
      uname = udata.displayName;
      uid = udata.uid;
      uimage = udata.photoUrl;
      isloggedString = 'LogOut';
      uemail = udata.email;
      logcolor = Colors.red;
    });
  }

  void refresh() async {
    postslength = 0;
    txt.clear();
    titles.clear();
    img.clear();
    authors.clear();
    dates.clear();
    setState(() {
      postamount = 0;
      mainStream(1);
    });
  }

  @override
  void initState() {
    super.initState();
    mainStream(1);
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      drawerScrimColor: Colors.grey[900].withOpacity(0.95),
      drawer: drawer(h, w),
      backgroundColor: Colors.green,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Android වැඩකාරයෝ'),
      ),
      //bottomNavigationBar: btnav(),
      body: PageView(
          controller: pgcontroller,
          onPageChanged: (index) {
            setState(() {
              pageindex = index;
            });
          },
          children: <Widget>[
            SmartRefresher(
              enablePullDown: true,
              header: WaterDropMaterialHeader(),
              onRefresh: () {
                refresh();
              },
              controller: refreshController,
              child: ListView.builder(
                  itemCount: postamount,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(8),
                      width: w * 0.9,
                      child: InkWell(
                        splashColor: Colors.green[900],
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Article(
                                        img: img[index],
                                        post: txt[index],
                                        title: titles[index],
                                        author: authors[index],
                                        dates: dates[index],
                                        url: links[index],
                                      )));
                        },
                        child: Card(
                          elevation: 8,
                          shape: rounded(16.0),
                          child: Column(
                            children: <Widget>[
                              Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(16),
                                      topLeft: Radius.circular(16),
                                    ),
                                    child: new CachedNetworkImage(
                                      imageUrl: img[index],
                                      placeholder: (context, url) => Container(
                                        margin: EdgeInsets.all(8),
                                        padding: EdgeInsets.all(8),
                                        child: LinearProgressIndicator(
                                          backgroundColor: Colors.green,
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          LinearProgressIndicator(
                                        backgroundColor: Colors.green,
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      ),
                                    ),
                                  ),
                                  isLogged
                                      ? Column(
                                          children: <Widget>[
                                            FloatingActionButton(
                                                heroTag: postid[index] + 'AS',
                                                mini: true,
                                                child: Icon(Icons.add),
                                                onPressed: () {
                                                  addtoSaved(
                                                      titles[index],
                                                      links[index],
                                                      postid[index]);
                                                }),
                                            FloatingActionButton(
                                                heroTag: postid[index] + 'LV',
                                                mini: true,
                                                backgroundColor:
                                                    lovelist[index],
                                                child: Icon(Icons.favorite),
                                                onPressed: () {
                                                  setState(() {
                                                    lovelist[index] ==
                                                            Colors.pink
                                                        ? lovelist[index] =
                                                            Colors.green
                                                        : lovelist[index] =
                                                            Colors.pink;
                                                  });
                                                }),
                                            Text('600')
                                          ],
                                        )
                                      : Container()
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.all(4),
                                padding: EdgeInsets.all(4),
                                child: Text(
                                  titles[index],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Cats(),
            SavedItems(),
          ]),
    );
  }

  Column drawer(h, w) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: w * 0.2,
              width: w * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(256),
                child: new CachedNetworkImage(
                  imageUrl: uimage,
                  placeholder: (context, url) => Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(8),
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.green,
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            Text(
              uname,
              style: whiteboldtxt(16),
            ),
            Text(uemail, style: whitetxt(16)),
            RaisedButton(
                child: Text(
                  isloggedString,
                  style: whitetxt(16),
                ),
                color: logcolor,
                shape: rounded(16.0),
                onPressed: () async {
                  if (isloggedString == 'Login') {
                    signiner();
                  } else {
                    signoffer();
                  }
                })
          ],
        ),
        SizedBox(
          height: h / 4,
        ),
        Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 8),
              width: w * 0.6,
              height: 48,
              child: RaisedButton(
                elevation: 8,
                color: Colors.green,
                child: Text(
                  'Join Android වැඩකාරයෝ',
                  style: whitetxt(16),
                ),
                shape: roundedSideMenu(32.0),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8),
              width: w * 0.6,
              height: 48,
              child: RaisedButton(
                elevation: 8,
                color: Colors.green,
                child: Text(
                  'Visit WebSite',
                  style: whitetxt(16),
                ),
                shape: roundedSideMenu(32.0),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8),
              width: w * 0.6,
              height: 48,
              child: RaisedButton(
                elevation: 8,
                color: Colors.green,
                child: Text(
                  'Settings',
                  style: whitetxt(16),
                ),
                shape: roundedSideMenu(32.0),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  BottomNavigationBar btnav() {
    return BottomNavigationBar(
        showUnselectedLabels: false,
        elevation: 0,
        onTap: (idx) {
          pgcontroller.animateToPage(idx,
              duration: Duration(milliseconds: 250), curve: Curves.linear);
        },
        backgroundColor: Colors.transparent,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.5),
        currentIndex: pageindex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.list), title: Text('Categories')),
          BottomNavigationBarItem(icon: Icon(Icons.save), title: Text('Saved')),
        ]);
  }
}
