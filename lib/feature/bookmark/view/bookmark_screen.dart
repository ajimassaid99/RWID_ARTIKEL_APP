
import 'package:flutter/material.dart';

class Bookmark {
  final String title;
  final String url;

  Bookmark({required this.title, required this.url});
}

class DummyBookmarkData {
  static List<Bookmark> generateDummyBookmarks() {
    return [
      Bookmark(title: 'Bookmark 1', url: 'https://example.com/bookmark1'),
      Bookmark(title: 'Bookmark 2', url: 'https://example.com/bookmark2'),
      Bookmark(title: 'Bookmark 3', url: 'https://example.com/bookmark3')
    ];
  }
}

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  late List<Bookmark> bookmarks;

  @override
  void initState() {
    super.initState();
   bookmarks =  DummyBookmarkData.generateDummyBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
      ),
      body: ListView.builder(
        itemCount: bookmarks.length,
        itemBuilder: (context, index) => _buildBookmarkCard(bookmarks[index]),
      ),
    );
  }

  Widget _buildBookmarkCard(Bookmark bookmark) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 4.0,
      child: ListTile(
        title: Text(bookmark.title),
        subtitle: Text(bookmark.url),
        onTap: () {
       
        },
      ),
    );
  }
}
