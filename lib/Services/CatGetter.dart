import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';

var taglist = [];






Future catStreamMaker() async {
  taglist.clear();
  var response = await http.get(
      "https://androidwedakarayo.com/ghost/api/v3/content/tags?key=8aff8bccef419606356a20bf70");
  if (response.statusCode == 200) {
    taglist.clear();
    var posts = jsonDecode(response.body);
    posts['tags'].forEach((tag){
      taglist.add((tag['name']).toString());
    });
  }
  print(taglist);
  return taglist;
}
