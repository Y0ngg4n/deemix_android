import 'dart:collection';

import 'package:deemix_android/album.dart';
import 'package:deemix_android/artist.dart';
import 'package:deemix_android/queue.dart';
import 'package:deemix_android/settings.dart';
import 'package:deemix_android/track.dart';
import 'package:flutter/material.dart';

enum NavigationItem { Track, Album, Artist, Settings, Queue }

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  String title = "Deemix";
  NavigationItem selectedNavigationItem = NavigationItem.Track;
  bool search = false;
  Widget? selectedWidget;

  @override
  Widget build(BuildContext context) {
    switch (selectedNavigationItem) {
      case NavigationItem.Track:
        selectedWidget = Track();
        break;
      case NavigationItem.Album:
        selectedWidget = Album();
        break;
      case NavigationItem.Artist:
        selectedWidget = Artist();
        break;
      case NavigationItem.Settings:
        selectedWidget = Settings();
        break;
      case NavigationItem.Queue:
        selectedWidget = DownloadQueue();
        break;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(child: Text(title)),
            ListTile(
              title: const Text("Track"),
              onTap: () => setState(() {
                selectedNavigationItem = NavigationItem.Track;
                Navigator.pop(context);
              }),
            ),
            ListTile(
              title: const Text("Album"),
              onTap: () => setState(() {
                selectedNavigationItem = NavigationItem.Album;
                Navigator.pop(context);
              }),
            ),
            ListTile(
              title: const Text("Artist"),
              onTap: () => setState(() {
                selectedNavigationItem = NavigationItem.Artist;
                Navigator.pop(context);
              }),
            ),
            ListTile(
              title: const Text("Queue"),
              onTap: () => setState(() {
                selectedNavigationItem = NavigationItem.Queue;
                Navigator.pop(context);
              }),
            ),
            ListTile(
              title: const Text("Settings"),
              onTap: () => setState(() {
                selectedNavigationItem = NavigationItem.Settings;
                Navigator.pop(context);
              }),
            ),
          ],
        ),
      ),
      body: selectedWidget,
    );
  }
}
