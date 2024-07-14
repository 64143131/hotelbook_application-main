import 'package:flutter/material.dart';
import 'package:hotelbook_application/services/page_service.dart';

class PageDatailScreen extends StatefulWidget {
  final String id;
  const PageDatailScreen({super.key, required this.id});

  @override
  State<PageDatailScreen> createState() => _PageDatailScreenState();
}

class _PageDatailScreenState extends State<PageDatailScreen> {
  dynamic _page = {};

  @override
  void initState() {
    super.initState();
    PageService.fetchPage(widget.id).then((page) {
      setState(() {
        _page = page;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_page['title']),
      ),
      body: Container(
        child: Text(_page['contents']),
      ),
    );
  }
}
