import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  SharedPreferences? prefs;

  Future<void> loadPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      prefs = preferences;
    });
  }

  @override
  void initState() {
    super.initState();
    loadPrefs();
  }

  @override
  Widget build(BuildContext context) {
    if(prefs == null) return Container();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Form(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("URL: "),
                      ),
                      TextFormField(
                        initialValue: prefs!.getString("URL"),
                        decoration: const InputDecoration(
                            hintText: "URL", border: OutlineInputBorder()),
                        onChanged: (value) async {
                          prefs!.setString("URL", value);
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Basic Auth User: "),
                      ),
                      TextFormField(
                        initialValue: prefs!.getString("User"),
                        decoration: const InputDecoration(
                          hintText: "User",
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) async {
                          prefs!.setString("User", value);
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Basic Auth Password: "),
                      ),
                      TextFormField(
                        initialValue: prefs!.getString("Password"),
                        decoration: const InputDecoration(
                            hintText: "Password", border: OutlineInputBorder()),
                        onChanged: (value) async {
                          prefs!.setString("Password", value);
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("ARL: "),
                      ),
                      TextFormField(
                        initialValue: prefs!.getString("ARL"),
                        decoration: const InputDecoration(
                            hintText: "ARL", border: OutlineInputBorder()),
                        onChanged: (value) async {
                          prefs!.setString("ARL", value);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
