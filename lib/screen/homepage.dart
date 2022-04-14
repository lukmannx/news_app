import 'dart:js';

import 'package:flutter/material.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/screen/newspage.dart';
import 'package:news_app/service/data_service.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    News news = News();
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            image: DecorationImage(
              image: NetworkImage(
                'https://avatars.githubusercontent.com/u/89436199?v=4'
              )
            )
          ),
          width: 10,
          margin: EdgeInsets.all(5),
        ),
        title: Text(
          'Good Morning',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.bookmark),
            color: Colors.blue,
          )
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: news.getNews(),
        builder: (context, snapshot) => snapshot.data != null
        ? NewsPage(snapshot.data as List<Article>)
        : Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}