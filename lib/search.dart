import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

enum SearchType { Track, Album, Artist }

class Search extends StatefulWidget {
  SearchType searchType;

  Search({Key? key, required this.searchType}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<dynamic> responseData = [];

  Future<void> search(String term) async {
    String type = "";
    switch (widget.searchType) {
      case SearchType.Track:
        type = "track";
        break;
      case SearchType.Album:
        type = "album";
        break;
      case SearchType.Artist:
        type = "artist";
        break;
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String url = preferences.getString("URL") ?? "";
    String user = preferences.getString("User") ?? "";
    String password = preferences.getString("Password") ?? "";
    String basicAuth = 'Basic ${base64.encode(utf8.encode('$user:$password'))}';
    http.Response response = await http.get(
        Uri.parse("$url/api/search?type=$type&term=$term"),
        headers: {'authorization': basicAuth});
    if (response.statusCode == 200) {
      setState(() {
        responseData = jsonDecode(response.body)["data"];
      });
    }
  }

  void download(requestUrl) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String url = preferences.getString("URL") ?? "";
    String user = preferences.getString("User") ?? "";
    String password = preferences.getString("Password") ?? "";
    String arl = preferences.getString("ARL") ?? "";
    String basicAuth = 'Basic ${base64.encode(utf8.encode('$user:$password'))}';
    http.Response response = await http.post(Uri.parse("$url/api/loginArl"),
        headers: {'authorization': basicAuth}, body: {'arl': arl});
    if (response.statusCode == 200) {
      String? cookie = response.headers["set-cookie"];
      if (cookie != null || cookie!.isNotEmpty) {
        response = await http.post(Uri.parse("$url/api/addToQueue"),
            headers: {'authorization': basicAuth, 'Cookie': cookie},
            body: {'url': requestUrl});
        if (response.statusCode == 200 && jsonDecode(response.body)["result"]) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Added to queue!")));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
            child: TextFormField(
          onChanged: (value) => search(value),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(top: 15),
            hintText: "Search ...",
            prefixIcon: Icon(Icons.search),
          ),
        )),
        Expanded(
          child: ListView(
            children: [
              for (dynamic item in responseData)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Card(
                    child: ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Image.network(item["album"]["cover"]),
                      ),
                      title: Text(item["title"]),
                      trailing: IconButton(
                        icon: const Icon(Icons.download),
                        onPressed: () {
                          download(item["link"]);
                        },
                      ),
                    ),
                  ),
                )
            ],
          ),
        )
      ],
    );
  }
}
