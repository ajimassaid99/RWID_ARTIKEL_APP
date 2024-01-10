import 'dart:io';

import 'package:artikel_aplication/core/constant/colors.dart';
import 'package:artikel_aplication/core/extention/string_ext.dart';
import 'package:artikel_aplication/feature/home/bloc/tag_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  XFile? _image;

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(source: source);
    setState(() {
      _image = pickedImage;
    });
  }

  List<int> selectedtags = [];

  late TagBloc tagBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tagBloc = context.read<TagBloc>();

    tagBloc.add(const getTag());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary500,
        title: const Text(
          "Choose Your tags",
          style: TextStyle(color: AppColors.white),
        ),
      ),
      body: BlocConsumer<TagBloc, TagState>(
        listener: (context, state) {
          if (state is CreateSuccess) {
            "Data Berhasil Di Update".succeedBar(context);
          }
        },
        builder: (context, state) {
          if (state is TagLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is TagSuccess) {
            final List data = state.data;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _image == null
                      ? Text('No image selected.')
                      : Image.file(File(_image!.path)),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          _getImage(ImageSource.gallery);
                        },
                        child: Text('From Gallery'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _getImage(ImageSource.camera);
                        },
                        child: Text('From Camera'),
                      ),
                    ],
                  ),
                ],
              ),
            );
            //   return ListView.builder(
            //     itemCount: data.length,
            //     itemBuilder: (BuildContext context, int index) {
            //       final TagModel tag = data[index];
            //       final isSelected = selectedtags.contains(tag.id);

            //       return CheckboxListTile(
            //         title: Text(tag.tag),
            //         value: isSelected,
            //         onChanged: (bool? value) {
            //           setState(() {
            //             if (value != null && value) {
            //               selectedtags.add(tag.id);
            //             } else {
            //               selectedtags.remove(tag.id);
            //             }
            //           });
            //         },
            //       );
            //     },
            //   );
          }
          return const Center(
            child: Text("Data Kosong"),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          tagBloc.add(UpdateTag(
              tagId: 1, tagName: "Flutter 1", image: _image?.path ?? ''));
          // Implement logic to proceed based on selectedtags
          // For example, navigate to a new page passing the selected tags.
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => NextPage(selectedtags: selectedtags),
          //   ),
          // );
        },
        label: const Text('Continue'),
        backgroundColor: AppColors.primary500,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
