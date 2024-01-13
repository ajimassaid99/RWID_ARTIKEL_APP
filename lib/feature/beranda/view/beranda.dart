import 'package:artikel_aplication/core/constant/colors.dart';
import 'package:flutter/material.dart';

class Article {
  final String author;
  final String title;
  final String url_image;
  final DateTime createdAt;

  Article({
    required this.author,
    required this.title,
    required this.url_image,
    required this.createdAt,
  });
}

class DataTab {
  final String name;

  DataTab({required this.name});
}

class DummyData {
  static List<Article> generateDummyArticles() {
    return List.generate(
      10,
      (index) => Article(
        author: 'Author $index',
        title: 'Title $index',
        url_image:
            'https://placekitten.com/200/300', // Replace with actual image URLs
        createdAt: DateTime.now(),
      ),
    );
  }

  static List<DataTab> generateDummyTabs() {
    return [
      DataTab(name: 'Tab 1'),
      DataTab(name: 'Tab 2'),
      DataTab(name: 'Tab 3'),
      // Add more tabs as needed
    ];
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late List<DataTab> dataTab;
  late List<Article> articles;

  @override
  void initState() {
    super.initState();
    dataTab = DummyData.generateDummyTabs();
    articles = DummyData.generateDummyArticles();
  }

  Future<void> onRefresh() async {
    // Implement your refresh logic here
    // You can fetch new data or update existing data
    setState(() {
      articles = DummyData.generateDummyArticles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return onRefresh();
      },
      child: MaterialApp(
        home: DefaultTabController(
          length: dataTab.length,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.primary500,
              bottom: TabBar(
                isScrollable: true,
                tabs: [
                  for (var data in dataTab)
                    Tab(
                      text: data.name,
                    ),
                ],
              ),
              title: const Text(
                'Home',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 40),
              ),
            ),
            body: TabBarView(
              children: [
                for (var data in dataTab)
                  _buildArticleList(articles), // Adjust this based on tabs
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: const Icon(
                Icons.add_comment,
                color: AppColors.primary50,
              ),
              backgroundColor: AppColors.primary500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildArticleList(List<Article> articles) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) => _buildArticleCard(articles[index]),
    );
  }

  Widget _buildArticleCard(Article article) {
    return Card(
      color: AppColors.primary500,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 4.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            article.url_image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.author,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Text(
                  article.title,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(height: 8.0),
                Text(
                  article.createdAt.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Save to Bookmark',
                        style: TextStyle(color: AppColors.primary500),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
