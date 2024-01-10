import 'package:artikel_aplication/core/constant/colors.dart';
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
      header: const ClassicHeader(
        textStyle: (TextStyle(fontSize: 14, color: AppColors.primary500)),
        failedIcon:
            Icon(Icons.error_outline_rounded, color: AppColors.primary500),
        failedText: 'Gagal mengambil data',
        refreshingIcon: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(color: AppColors.primary500)),
        refreshingText: 'Mohon tunggu...',
        completeIcon:
            Icon(Icons.check_circle_outlined, color: AppColors.primary500),
        completeText: 'Berhasil mengambil data',
        releaseIcon: Icon(Icons.refresh, color: AppColors.primary500),
        releaseText: 'Lepas untuk refresh',
        idleIcon: Icon(Icons.arrow_downward, color: AppColors.primary500),
        idleText: 'Tarik ke bawah',
        spacing: 12.0,
      ),
      child: child,
    );
  }
}
