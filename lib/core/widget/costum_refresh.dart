import 'package:artikel_aplication/core/extention/screen_ext.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomSmartRefresher extends StatelessWidget {
  final RefreshController controller;
  final Widget? child;
  final VoidCallback? onRefresh;

  const CustomSmartRefresher({
    Key? key,
    required this.controller,
    this.child,
    this.onRefresh,
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
                const TextStyle(
                    fontSize: 14,
                    color: Colors.black))
            .copyWith(color: Colors.black),
        failedIcon: const Icon(Icons.error_outline_rounded,
            color: Colors.black),
        failedText: 'Gagal mengambil data',
        refreshingIcon: const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
                color: Colors.black)),
        refreshingText: 'Sedang Mengambil Data...',
        completeIcon: const Icon(Icons.check_circle_outlined,
            color: Colors.black),
        completeText: 'Berhasil mengambil data',
        releaseIcon: const Icon(Icons.refresh,
            color: Colors.black),
        releaseText: 'refresh',
        idleIcon: const Icon(Icons.arrow_downward,
            color: Colors.black),
        idleText: 'Tarik ke bawah Untuk Refresh',
        spacing: 12.0,
      ),
      child: child,
    );
  }
}
