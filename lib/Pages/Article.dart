import 'package:awapp/Styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:share/share.dart';

class Article extends StatefulWidget {
  final img;
  final post;
  final title;
  final author;
  final dates;
  final url;
  const Article(
      {Key key,
      this.img,
      this.post,
      this.title,
      this.author,
      this.dates,
      this.url})
      : super(key: key);
  @override
  _ArticleState createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  @override
  void initState() {
    super.initState();
    print(widget.img);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.green,
    ));
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: new Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: <Widget>[
                      new CachedNetworkImage(
                        imageUrl: widget.img,
                        placeholder: (context, url) => Container(
                          padding: EdgeInsets.all(8),
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.green,
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      Container(
                          width: 64,
                          margin: EdgeInsets.only(left: 16),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 8,
                              ),
                              RaisedButton(
                                  elevation: 4,
                                  color: Colors.white,
                                  shape: rounded(64.0),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(
                                    Icons.arrow_back,
                                    size: 32,
                                    color: Colors.grey[900],
                                  )),
                            ],
                          ))
                    ]),
              ),
              Container(
                height: h / 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'Android  වැඩකාරයෝ',
                      style: whiteboldtxt(24),
                    ),
                  ],
                ),
                color: Colors.green,
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: Text(
                  widget.title,
                  style: blackboldtxt(24),
                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.dates.toString().split('T')[0]),
                        Text(
                          'by ' + widget.author,
                          style: blackboldtxt(16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: Html(data: widget.post),
              ),
              Container(
                color: Colors.green,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                        onPressed: () {
                          Share.share(widget.url);
                        },
                        child: Icon(
                          Icons.share,
                          color: Colors.white,
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
