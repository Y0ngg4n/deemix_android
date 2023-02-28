import 'package:deemix_android/search.dart';
import 'package:flutter/material.dart';

class Album extends StatefulWidget {
  const Album({Key? key}) : super(key: key);

  @override
  State<Album> createState() => _AlbumState();
}

class _AlbumState extends State<Album> {
  @override
  Widget build(BuildContext context) {
    return Search(searchType: SearchType.Album);
  }
}
