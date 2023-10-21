import 'package:app_api/Album/albumlist.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<AlbumsItem>? _albumList;
  final _dio = Dio(BaseOptions(responseType: ResponseType.plain));

  void getAlbums() async {
    try {
      final response =
          await _dio.get('https://jsonplaceholder.typicode.com/albums');
      debugPrint(response.data.toString());
      List list = jsonDecode(response.data.toString());
      setState(() {
        _albumList = list.map((item) => AlbumsItem.fromJson(item)).toList();
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAlbums();
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    body = _albumList == null
        ? const Center(child: CircularProgressIndicator())
        : IsWork();
    return body;
  }

  Scaffold IsWork() {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Text(
              "Photo Albums",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _albumList!.length,
                itemBuilder: (context, index) {
                  var albumItem = _albumList![index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            albumItem.title.toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.red[100],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                ),
                                child: Text(
                                  "Album ID : " + albumItem.id.toString(),
                                ),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.blue[100],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                ),
                                child: Text(
                                  "User ID : " + albumItem.userId.toString(),
                                ),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
