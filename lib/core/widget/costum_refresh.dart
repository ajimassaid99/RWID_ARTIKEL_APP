import 'package:artikel_aplication/core/extention/screen_ext.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomSmartRefresher extends StatelessWidget {
  final RefreshController controller;
  final Widget? child;
  final VoidCallback? onRefresh;
  final bool isDark;

  const CustomSmartRefresher({
    Key? key,
    required this.controller,
    this.child,
    this.onRefresh,
    this.isDark = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: controller,
      physics: const BouncingScrollPhysics(
        parent: NeverScrollableScrollPhysics(),
      ),
      onRefresh: onRefresh,
      header: ClassicHeader(
        textStyle: (context.text.bodyMedium ??
                TextStyle(
                    fontSize: 14,
                    color: isDark ? context.onBackground : context.onPrimary))
            .copyWith(color: isDark ? context.onBackground : context.onPrimary),
        failedIcon: Icon(Icons.error_outline_rounded,
            color: isDark ? context.onBackground : context.onPrimary),
        failedText: 'Gagal mengambil data',
        refreshingIcon: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
                color: isDark ? context.onBackground : context.onPrimary)),
        refreshingText: 'Sedang Mengambil Data...',
        completeIcon: Icon(Icons.check_circle_outlined,
            color: isDark ? context.onBackground : context.onPrimary),
        completeText: 'Berhasil mengambil data',
        releaseIcon: Icon(Icons.refresh,
            color: isDark ? context.onBackground : context.onPrimary),
        releaseText: 'refresh',
        idleIcon: Icon(Icons.arrow_downward,
            color: isDark ? context.onBackground : context.onPrimary),
        idleText: 'Tarik ke bawah Untuk Refresh',
        spacing: 12.0,
      ),
      child: child,
    );
  }
}
