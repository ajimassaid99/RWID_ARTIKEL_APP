import 'package:artikel_aplication/core/constant/colors.dart';
import 'package:artikel_aplication/core/constant/images.dart';
import 'package:artikel_aplication/feature/artikel/view/artikel_screen.dart';
import 'package:artikel_aplication/feature/bookmark/view/bookmark_screen.dart';
import 'package:artikel_aplication/feature/profile/view/profile_screen.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          DashboardScreen(),
          BookmarkScreen(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: AppColors.grey500,
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () => _onTap(0),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 4),
                  decoration: BoxDecoration(
                      color: _currentIndex == 0
                          ? AppColors.primary300
                          : AppColors.white,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: const ImageIcon(AppImages.beranda),
                ),
              ),
            ),
            label: 'Dashboard',
            backgroundColor: AppColors.white,
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () => _onTap(1),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 4),
                  decoration: BoxDecoration(
                      color: _currentIndex == 1
                          ? AppColors.primary300
                          : AppColors.white,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: const ImageIcon(AppImages.bookmark),
                ),
              ),
            ),
            label: 'Bookmark',
            backgroundColor: AppColors.white,
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () => _onTap(2),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 4),
                  decoration: BoxDecoration(
                      color: _currentIndex == 2
                          ? AppColors.primary300
                          : AppColors.white,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: const ImageIcon(AppImages.profile),
                ),
              ),
            ),
            label: 'Profil',
            backgroundColor: AppColors.white,
          ),
        ],
      ),
    );
  }
}
