import 'package:artikel_aplication/core/constant/colors.dart';
import 'package:artikel_aplication/core/widget/costum_refresh.dart';
import 'package:artikel_aplication/core/widget/shimmer_widget.dart';
import 'package:artikel_aplication/feature/artikel/bloc/artikel_bloc.dart';
import 'package:artikel_aplication/feature/artikel/model/artikel_model.dart';
import 'package:artikel_aplication/feature/artikel/view/detail_artikel_screen.dart';
import 'package:artikel_aplication/feature/artikel/view/widget/artikel_form.dart';
import 'package:artikel_aplication/feature/bookmark/bloc/bookmark_bloc.dart';
import 'package:artikel_aplication/feature/bookmark/model/bookmark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late ArtikelBloc artikelBloc;
  late BookmarkBloc bookmarkBloc;

  @override
  void initState() {
    super.initState();
    artikelBloc = context.read<ArtikelBloc>();
    artikelBloc.add(const GetArtikel());
    bookmarkBloc = context.read<BookmarkBloc>();
    bookmarkBloc.add(const GetBookmark());
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  Future<void> _onRefresh(BuildContext context) async {
    artikelBloc.add(const GetArtikel());
    await Future.delayed(const Duration(seconds: 2));
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary500,
          title: const Text(
            'Home',
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 40,
                color: AppColors.white),
          ),
        ),
        body: BlocBuilder<ArtikelBloc, ArtikelState>(
          builder: (context, state) {
            List<ArtikelModel> artikels = [];
            if (state is ArtikelLoading) {
              return _buildArticleListShimmer();
            }
            if (state is ArtikelSuccess) {
              artikels = state.data;
            }
            return CustomSmartRefresher(
                controller: _refreshController,
                onRefresh: () async => await _onRefresh(context),
                child: _buildArticleList(artikels));
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const ArticleForm(),
              ),
            );
          },
          backgroundColor: AppColors.primary500,
          child: const Icon(
            Icons.add_comment,
            color: AppColors.primary50,
          ),
        ),
      ),
    );
  }

  Widget _buildArticleListShimmer() {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) => _buildShimmerArticleCard(ArtikelModel(
          id: 0,
          author: '',
          authorProfile: '',
          title: '',
          urlImage: '',
          createdAt: '',
          content: '')),
    );
  }

  Widget _buildArticleList(List<ArtikelModel> articles) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) => _buildArticleCard(articles[index]),
    );
  }

  Widget _buildArticleCard(ArtikelModel article) {
    DateTime tanggalAwal = DateTime.parse(article.createdAt);
    String tanggalDiformat =
        DateFormat('dd MMMM yyyy', 'id').format(tanggalAwal);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => ArtikelDetailPage(
             id: article.id,
            ),
          ),
        );
      },
      child: Card(
        color: AppColors.primary500,
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        elevation: 4.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(article.authorProfile),
                    radius: 20.0,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    article.author,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          article.title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              8.0), // Adjust the radius as needed
                          child: Image.network(
                            article.urlImage,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tanggalDiformat,
                        style: const TextStyle(color: Colors.white),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.remove_red_eye,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 8.0),
                          const Text(
                            '20',
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(width: 8.0),
                          BlocBuilder<BookmarkBloc, BookmarkState>(
                            builder: (context, state) {
                              List<BookmarkModel> bookmarks = [];
                              if (state is BookmarkSuccess) {
                                bookmarks = state.data;
                              }
                              if (state is BookmarkLoading) {
                                return const ShimmerLoadingWidget(
                                  height: 20,
                                  width: 30,
                                );
                              }
                              print("state ini $state");
                              return IconButton(
                                onPressed: () {
                                  bookmarks.any((bookmark) =>
                                          bookmark.artikelId == article.id)
                                      ? bookmarkBloc.add(
                                          DeleteBookmark(artikelId: article.id))
                                      : bookmarkBloc.add(InsertBookmark(
                                          artikelId: article.id));
                                },
                                icon: Icon(
                                  Icons.bookmark,
                                  color: bookmarks.any((bookmark) =>
                                          bookmark.artikelId == article.id)
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerArticleCard(ArtikelModel article) {
    return Card(
      color: AppColors.primary500,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 4.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(article.authorProfile),
                  radius: 20.0,
                ),
                const SizedBox(width: 8.0),
                const ShimmerLoadingWidget(
                  height: 20,
                  width: 100,
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerLoadingWidget(
                            height: 20,
                            width: 200,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ShimmerLoadingWidget(
                            height: 20,
                            width: 150,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      flex: 1,
                      child: ShimmerLoadingWidget(
                        height: 60,
                        width: double.infinity,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerLoadingWidget(
                      height: 20,
                      width: 100,
                    ),
                    Row(
                      children: [
                        ShimmerLoadingWidget(
                          height: 20,
                          width: 20,
                        ),
                        SizedBox(width: 8.0),
                        ShimmerLoadingWidget(
                          height: 20,
                          width: 30,
                        ),
                        SizedBox(width: 8.0),
                        ShimmerLoadingWidget(
                          height: 20,
                          width: 30,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
