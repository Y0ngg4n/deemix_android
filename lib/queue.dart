import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DownloadQueue extends StatefulWidget {
  const DownloadQueue({Key? key}) : super(key: key);

  @override
  State<DownloadQueue> createState() => _DownloadQueueState();
}

class _DownloadQueueState extends State<DownloadQueue> {
  Map<String, dynamic> queueList = {};

  Future<void> getQueue() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String url = preferences.getString("URL") ?? "";
    String user = preferences.getString("User") ?? "";
    String password = preferences.getString("Password") ?? "";
    String basicAuth = 'Basic ${base64.encode(utf8.encode('$user:$password'))}';
    http.Response response = await http.get(Uri.parse("$url/api/getQueue"),
        headers: {'authorization': basicAuth});
    if (response.statusCode == 200) {
      setState(() {
        queueList = jsonDecode(response.body)["queue"];
      });
    }
    print(queueList);
  }

  @override
  void initState() {
    super.initState();
    getQueue();
  }

  @override
  Widget build(BuildContext context) {
    if(queueList.isEmpty) return const Center(child: SpinKitPouringHourGlass(color: Colors.blue));
    return Column(
      children: [
        Form(
            child: TextFormField(
                onChanged: (value) {},
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(top: 15),
                  hintText: "Search ...",
                  prefixIcon: Icon(Icons.search),
                ))),
        Expanded(
          child: ListView(
            children: [
              for (dynamic item in queueList.values.toList().reversed)
                if (item["type"] == "playlist")
                  ListTile(
                    title: Text(item["title"]),
                    trailing: Row(mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                            "${item["downloaded"]}/${item["size"]}",
                            style: item["downloaded"] < item["size"]
                                ? const TextStyle(color: Colors.orange)
                                : const TextStyle(color: Colors.black)),
                        Text(
                            " Fail: ${item["failed"]}",
                            style: const TextStyle(color: Colors.red)),
                      ],
                    ),
                  )
            ],
          ),
        )
      ],
    );
  }
}
