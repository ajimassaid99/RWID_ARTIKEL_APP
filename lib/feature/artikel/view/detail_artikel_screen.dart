import 'package:artikel_aplication/core/widget/costum_image.dart';
import 'package:artikel_aplication/feature/artikel/bloc/artikel_bloc.dart';
import 'package:artikel_aplication/feature/artikel/model/artikel_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ArtikelDetailPage extends StatefulWidget {
  final int id;
  const ArtikelDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<ArtikelDetailPage> createState() => _ArtikelDetailPageState();
}

class _ArtikelDetailPageState extends State<ArtikelDetailPage> {
  String user_id = '';
    final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
     supabase.auth.onAuthStateChange.listen((data) {
      if (data.session != null) {
        setState(() {
          user_id = data.session?.user.id??'';
          context.read<ArtikelBloc>().add(GetDetailArtikel(id: widget.id, userId: user_id));
        });
      }
    });

    
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Artikel'),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<ArtikelBloc, ArtikelState>(
          builder: (context, state) {
            if (state is ArtikelLoading) {
              // return ErrorOutput(message: state.message);
            }
            if (state is ArtikelDetailSuccess) {
              final ArtikelModel artikel = state.data;

              DateTime tanggalAwal = DateTime.parse(artikel.createdAt);

              // Format tanggal dalam format yang diinginkan (nama tanggal bulan tahun)
              String tanggalDiformat =
                  DateFormat('dd MMMM yyyy', 'id').format(tanggalAwal);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            artikel.title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(artikel.authorProfile),
                                radius: 20,
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    artikel.author,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    tanggalDiformat,
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                        ]),
                  ),
                  // Image.network(
                  //   artikel.urlImage,
                  //   height: 200,
                  //   width: MediaQuery.of(context).size.width,
                  //   fit: BoxFit.cover,
                  // ),
                  CustomImageNetwork(artikel.urlImage, height: 200),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: RichText(
                      text: TextSpan(
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                        children: [
                          ...artikel.content.split('\n').map((paragraph) {
                            return TextSpan(
                              text: paragraph.trimLeft(),
                              style: const TextStyle(
                                height: 1.5,
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
