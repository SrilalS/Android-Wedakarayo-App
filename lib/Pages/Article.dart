import 'package:awapp/Styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';

class Article extends StatefulWidget {
  final img;
  final post;
  final title;
  final author;
  final dates;
  const Article(
      {Key key, this.img, this.post, this.title, this.author, this.dates})
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
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Stack(
                  alignment: AlignmentDirectional.topStart,
                  children: <Widget>[
                    Image.network(
                      widget.img,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          height: 128,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                    ),
                    Container(
                        width: 64,
                        margin: EdgeInsets.all(4),
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
                      Text('by ' + widget.author, style: blackboldtxt(16),),
                    ],
                  ),
                ),
              ],
            ),
            
            Container(
              padding: EdgeInsets.all(8),
              child: Html(data: widget.post),
            )
          ],
        ),
      ),
    );
  }
}
