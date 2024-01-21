import 'dart:math';

import 'package:artikel_aplication/core/constant/colors.dart';
import 'package:artikel_aplication/core/extention/screen_ext.dart';
import 'package:artikel_aplication/core/widget/responsive_builder.dart';
import 'package:artikel_aplication/core/widget/costum_refresh.dart';
import 'package:artikel_aplication/feature/home/bloc/tag_bloc.dart';
import 'package:artikel_aplication/feature/home/model/tag.dart';
import 'package:artikel_aplication/feature/home/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

class PilihKelasScreen extends StatefulWidget {
  const PilihKelasScreen({Key? key}) : super(key: key);

  @override
  State<PilihKelasScreen> createState() => _PilihKelasScreenState();
}

class _PilihKelasScreenState extends State<PilihKelasScreen> {
  late TagBloc tagBloc;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();
    tagBloc = context.read<TagBloc>();
    tagBloc.add(const getTag());
  }

  Future<void> _onRefresh(BuildContext context) async {
    // monitor network fetch
    tagBloc.add(const getTag());
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  List<int> selectedId = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomSmartRefresher(
      controller: _refreshController,
      onRefresh: () async => await _onRefresh(context),
      child: SafeArea(
        child: ResponsiveBuilder(
          mobile: Column(
            children: [
              _buildTitleHeader(context),
              BlocConsumer<TagBloc, TagState>(
                listener: (context, state) {
                  if (state is CreateSuccess) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const MyHomePage(),
                      ),
                      (route) => false,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is TagLoading) {
                    return Shimmer.fromColors(
                      baseColor: AppColors.grey400,
                      highlightColor: AppColors.grey50,
                      child: _buildShimmerWrap(context),
                    );
                  }
                  List<TagModel> data = [];
                  if (state is TagSuccess) {
                    data = state.data;
                  }
                  return _buildWrapPilihanKelas(context, data);
                },
              ),
              _buildButton(context)
            ],
          ),
          tablet: Row(
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    const Spacer(),
                    Image.asset(
                      'assets/image/logo.jpeg',
                      width: 300,
                      height: 300,
                    ),
                    _buildTitleHeader(context),
                    const Spacer(),
                    _buildButton(context),
                  ],
                ),
              ),
              VerticalDivider(
                indent: context.dp(20),
                endIndent: context.dp(20),
              ),
              BlocConsumer<TagBloc, TagState>(
                listener: (context, state) {
                  if (state is CreateSuccess) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const MyHomePage(),
                      ),
                      (route) => false,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is TagLoading) {
                    return Flexible(
                      flex: 5,
                      child: Shimmer.fromColors(
                        baseColor: AppColors.grey400,
                        highlightColor: AppColors.grey50,
                        child: _buildShimmerWrap(context),
                      ),
                    );
                  }
                  List<TagModel> data = [];
                  if (state is TagSuccess) {
                    data = state.data;
                  }
                  return _buildWrapPilihanKelas(context, data);
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Padding _buildButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ElevatedButton(
        onPressed: () async {
          tagBloc.add(CreateUserTag(tagId: selectedId));
        },
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            backgroundColor: AppColors.primary500),
        child: const Text(
          'Lanjutkan',
          style: TextStyle(color: AppColors.white),
        ),
      ),
    );
  }

  Widget _buildShimmerWrap(BuildContext context) {
    return Wrap(
      children: List.generate(
        30,
        (index) {
          String placeholder = " " * (index % 10 * 5);
          return _buildOptionTag(
            context,
            () {},
            placeholder,
            false,
          );
        },
      ),
    );
  }

  Widget _buildOptionTag(BuildContext context, VoidCallback onClick,
          String label, bool isActive) =>
      InkWell(
        onTap: onClick,
        borderRadius: BorderRadius.circular(max(8, context.dp(8))),
        child: Container(
          margin: EdgeInsets.all((context.isMobile) ? context.dp(6) : 8),
          padding: EdgeInsets.symmetric(
            vertical: (context.isMobile) ? context.dp(10) : context.dp(6),
            horizontal: (context.isMobile) ? context.dp(12) : context.dp(8),
          ),
          decoration: BoxDecoration(
              color: isActive ? AppColors.primary500 : Colors.transparent,
              borderRadius: BorderRadius.circular(max(8, context.dp(8))),
              border: Border.all(
                  color: isActive ? Colors.transparent : context.onBackground)),
          child: Text(
            label,
            style: context.text.bodySmall?.copyWith(
              fontSize: (context.isMobile) ? 12 : 10,
              color: isActive ? context.onPrimary : context.onBackground,
            ),
          ),
        ),
      );

  Expanded _buildWrapPilihanKelas(BuildContext context, List<TagModel> data) {
    final ScrollController scrollController = ScrollController();
    return Expanded(
      flex: (context.isMobile) ? 1 : 5,
      child: Scrollbar(
        controller: scrollController,
        thumbVisibility: true,
        trackVisibility: true,
        thickness: 8,
        radius: const Radius.circular(14),
        child: SingleChildScrollView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          child: Padding(
              padding: EdgeInsets.only(
                top: (context.isMobile) ? 0 : context.dp(10),
                right: (context.isMobile) ? context.dp(18) : context.dp(10),
                left: (context.isMobile) ? context.dp(18) : context.dp(10),
                bottom: (context.isMobile) ? context.dp(24) : context.dp(16),
              ),
              child: Wrap(
                children: data
                    .map<Widget>(
                      (tag) => _buildOptionTag(
                        context,
                        () async {
                          setState(() {
                            if (selectedId.contains(tag.id)) {
                              selectedId.remove(tag.id);
                            } else {
                              selectedId.add(tag.id);
                            }
                          });
                        },
                        tag.tag,
                        selectedId.contains(tag.id),
                      ),
                    )
                    .toList(),
              )),
        ),
      ),
    );
  }

  Padding _buildTitleHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: (context.isMobile) ? context.dp(8) : context.dp(14),
        right: (context.isMobile) ? context.dp(24) : context.dp(14),
        top: (context.isMobile) ? context.dp(24) : 0,
        bottom: (context.isMobile) ? context.dp(24) : 0,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: context.dp(268),
                  child: FittedBox(
                    child: RichText(
                      text: TextSpan(
                          text: '',
                          children: [
                            TextSpan(
                              text: 'Selamat datang di RWID Artikel',
                              style: context.text.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                          style: context.text.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w600)),
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      textScaleFactor: context.textScale14,
                    ),
                  ),
                ),
                SizedBox(height: context.h(16)),
                SizedBox(
                  width: context.dp(268),
                  child: FittedBox(
                    child: Text(
                      'Pilih minatmu sekarang dan temukan bacaan menarik!',
                      style: context.text.bodySmall,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// NOTE: kumpulan Widget END-------------------------------------------------
}
