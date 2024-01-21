import 'package:artikel_aplication/core/constant/colors.dart';
import 'package:artikel_aplication/core/constant/icon.dart';
import 'package:artikel_aplication/core/extention/doubel_ext.dart';
import 'package:artikel_aplication/core/widget/button_widget.dart';
import 'package:artikel_aplication/feature/auth/bloc/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: ListView(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.0.height,
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "My Profile",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                16.0.height,
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30.0,
                        backgroundColor: AppColors.primary50,
                        child: ClipOval(
                          child: Image(
                            image: AppIcons.profile,
                            width: 30,
                          ),
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Muhammad Aji Massaid',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            '@Amassaid99',
                            style: TextStyle(
                              color: AppColors.grey500,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                20.0.height,
                const Divider(
                  thickness: 1,
                  color: AppColors.grey50,
                ),
                8.0.height,
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ImageIcon(
                            size: 20,
                            AppIcons.email,
                            color: AppColors.primary500,
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.grey700,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Amassaid99@gmail.com',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.grey700,
                        ),
                      ),
                    ],
                  ),
                ),
                16.0.height,
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ImageIcon(
                            size: 20,
                            AppIcons.numberPhone,
                            color: AppColors.primary500,
                          ),
                          SizedBox(width: 12),
                          Text(
                            'No. Telepon',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.grey700,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '0812345678910',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.grey700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(
              thickness: 10,
              color: AppColors.grey50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 12 / 2),
                  child: Text(
                    "Akun",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 12 / 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ImageIcon(
                              size: 20,
                              AppIcons.ubahProfil,
                              color: AppColors.primary500,
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Ubah Profile',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.grey700,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: AppColors.grey700,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              thickness: 10,
              color: AppColors.grey50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 12 / 2),
                  child: Text(
                    "Keamanan",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 12 / 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ImageIcon(
                              size: 20,
                              AppIcons.password,
                              color: AppColors.primary500,
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Ubah Password',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.grey700,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: AppColors.grey700,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            40.0.height,
            Container(
              color: AppColors.grey50,
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
                  child: FormButton(
                    label: 'Log out',
                    onPressed: () {
                      // Tampilkan dialog konfirmasi
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Konfirmasi Logout'),
                            content:
                                const Text('Apakah Anda yakin ingin logout?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  // Tutup dialog
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Batal'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Lakukan logout
                                  context.read<AuthenticationBloc>().add(
                                      const SignOut());
                                  Navigator.of(context)
                                      .pop(); 
                                },
                                child: const Text('Ya, Logout'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    backgroundColor: AppColors.error500,
                  )),
            ),
          ],
        ),
      ]),
    );
  }
}
