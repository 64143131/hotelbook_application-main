import 'dart:convert';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:hotelbook_application/config/app.dart';
import 'package:hotelbook_application/screen/page_detail_sreen.dart';
import 'package:hotelbook_application/services/auth_service.dart';
import 'package:hotelbook_application/services/page_service.dart';
import 'package:hotelbook_application/services/post_service.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> banners = [];
  List<dynamic> pages = [];
  List<dynamic> posts = [];
  Future<void> fetchBanners() async {
    try {
      final response = await http.get(Uri.parse('$API_URL/api/banners'));
      final banners = jsonDecode(response.body);
      print(banners);
      setState(() {
        this.banners = banners;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchPages() async {
    try {
      List<dynamic> pages = await PageService.fetchPages();
      setState(() {
        this.pages = pages;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchPosts() async {
    try {
      List<dynamic> posts = await PostService.fetchPages();
      setState(() {
        this.posts = posts;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    AuthService.checkLogin().then((loggedIn) {
      if (!loggedIn) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });

    fetchBanners();
    fetchPages();
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: pages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PageDatailScreen(
                          id: pages[index]['id'],
                        ),
                      ),
                    );
                  },
                  title: Text(pages[index]['title']),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            child: Swiper(
              autoplay: true,
              itemCount: banners.length,
              itemBuilder: (context, index) {
                return Image.network(
                  '$API_URL/${banners[index]['imageUrl']}',
                );
              },
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  trailing: const Icon(Icons.chevron_right),
                  leading: Image.asset('images/1.png'),
                  title: Text(posts[index]['title']),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PageDatailScreen(
                          id: posts[index]['id'],
                        ),
                      ),
                    );
                  },
                );
              })
        ],
      ),
    );
  }
}
