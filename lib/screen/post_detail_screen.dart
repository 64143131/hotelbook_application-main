import 'package:flutter/material.dart';
import 'package:hotelbook_application/services/post_service.dart';

class PostDatailScreen extends StatefulWidget {
  final String id;
  const PostDatailScreen({super.key, required this.id});

  @override
  State<PostDatailScreen> createState() => _PostDatailScreenState();
}

class _PostDatailScreenState extends State<PostDatailScreen> {
  dynamic _post = {};

  @override
  void initState() {
    super.initState();
    PostService.fetchPage(widget.id).then((post) {
      setState(() {
        _post = post;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_post['title']),
      ),
      body: Container(
        child: Text(_post['contents']),
      ),
    );
  }
}
