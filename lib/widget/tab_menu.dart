import 'dart:ffi';

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/screen/newspage.dart';
import 'package:news_app/service/data_service.dart';
import 'package:news_app/widget/news_item.dart';

class TabBarMenu extends StatefulWidget {
  final List<Article> article;

  TabBarMenu(this.article);

  @override
  _TabBarMenuState createState() => _TabBarMenuState();
}

class _TabBarMenuState extends State<TabBarMenu>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Tab> myTabs = <Tab>[
    Tab(
      text: 'Bussiness',
    ),
    Tab(
      text: 'Entertainment',
    ),
    Tab(
      text: 'General',
    ),
    Tab(
      text: 'Health',
    ),
    Tab(
      text: 'Science',
    ),
    Tab(
      text: 'Sports',
    ),
    Tab(
      text: 'Technology',
    )
  ];

  @override
  void initState() {
    _tabController = TabController(length: myTabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    News news = News();
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: Colors.deepOrangeAccent,
            unselectedLabelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BubbleTabIndicator(
                indicatorColor: Colors.black,
                indicatorHeight: 30,
                tabBarIndicatorSize: TabBarIndicatorSize.tab),
            tabs: myTabs,
            isScrollable: true,
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: myTabs.map((Tab tab) {
                // disini kita menggunakan featrue builder karena
                // kita bisa dengan mudah mendapatkan status dari proses
                // yang sedang kita jalankan, misalnya seperti
                // menampilkan loading saat memuat data
                // dari server menggunakan API, lalu menampilkan datanya
                // saat sudah siap dan di terima
                return FutureBuilder(
                  future: news.getNewsCategory(tab.text.toString()),
                  builder: (context, snapshot) => snapshot.data != null
                      ? _listNewsCategory(snapshot.data as List<Article>)
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listNewsCategory(List<Article> articles) {
    return Container(
      height: MediaQuery.of(context).size.height,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ListView.builder(
        itemBuilder: (context, index) => NewsItem(
          article: articles[index],
        ),
        itemCount: articles.length,
      ),
    );
  }
}
