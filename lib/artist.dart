import 'package:deemix_android/search.dart';
import 'package:flutter/material.dart';

class Artist extends StatefulWidget {
  const Artist({Key? key}) : super(key: key);

  @override
  State<Artist> createState() => _ArtistState();
}

class _ArtistState extends State<Artist> {
  @override
  Widget build(BuildContext context) {
    return Search(searchType: SearchType.Artist,);
  }
}
