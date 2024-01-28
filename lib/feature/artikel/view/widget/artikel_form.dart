import 'package:artikel_aplication/core/extention/string_ext.dart';
import 'package:artikel_aplication/feature/artikel/bloc/artikel_bloc.dart';
import 'package:artikel_aplication/feature/home/bloc/tag_bloc.dart';
import 'package:artikel_aplication/feature/home/model/tag.dart';
import 'package:artikel_aplication/feature/home/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class ArticleForm extends StatefulWidget {
  const ArticleForm({Key? key}) : super(key: key);

  @override
  State<ArticleForm> createState() => _ArticleFormState();
}

class _ArticleFormState extends State<ArticleForm> {
  String title = '';
  int selectedTag = 0;
  String content = '';
  File? selectedImage;
  String user_id='';
  final _formKey = GlobalKey<FormState>();
  final supabase = Supabase.instance.client;

  List<TagModel> tags = [TagModel(id: 0, tag: "")];

  @override
  void initState() {
    super.initState();
    final tagBloc = BlocProvider.of<TagBloc>(context);

    tagBloc.add(const getTag());
    supabase.auth.onAuthStateChange.listen((data) {
      if (data.session != null) {
        setState(() {
          user_id = data.session?.user.id??'';
        });
      }
    });
    tagBloc.stream.listen((state) {
      if (state is TagSuccess) {
        setState(() {
          if (state.data.isNotEmpty) {
            tags = state.data;
            selectedTag = state.data[0].id;
          }
        });
      }
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Article'),
        ),
        body:
            BlocConsumer<ArtikelBloc, ArtikelState>(listener: (context, state) {
          if (state is ArtikelCreateSucces) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const MyHomePage(),
              ),
              (route) => false,
            );
          }

          if (state is ArtikelFailed) {
            "Gagal Menambah Data Artikel".failedBar(context);
          }
        }, builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              const Text(
                'Title:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    title = value;
                  });
                },
                validator: (value) {
                  if (value == '' || value == null) {
                    return 'Title cannot be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Tag:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              DropdownButton<int>(
                value: selectedTag,
                onChanged: (value) {
                  setState(() {
                    selectedTag = value!;
                  });
                },
                items: tags.map((tag) {
                  return DropdownMenuItem<int>(
                    value: tag.id,
                    child: Text(tag.tag),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              const Text(
                'Image:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              selectedImage != null
                  ? Image.file(selectedImage!, height: 100, width: 100)
                  : const SizedBox(
                      height: 100, width: 100, child: Placeholder()),
              ElevatedButton(
                onPressed: () {
                  _pickImage();
                },
                child: const Text('Pick Image'),
              ),
              const SizedBox(height: 20),
              const Text(
                'Content:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    content = value;
                  });
                },
                validator: (value) {
                  if (value == '' || value == null) {
                    return 'Content cannot be empty';
                  }
                  return null;
                },
                maxLines: null, // Allows multiple lines for content
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.read<ArtikelBloc>().add(CreateArtikel(
                      tag: selectedTag,
                      title: title,
                      content: content,
                      image: selectedImage!,
                      userId: user_id));
                },
                child: const Text('Save Article'),
              ),
            ],
          );
        }));
  }
}
