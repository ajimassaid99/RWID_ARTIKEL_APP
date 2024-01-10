import 'dart:io';
import 'dart:math';

import 'package:artikel_aplication/feature/home/model/tag.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:developer' as logger show log;

part 'tag_event.dart';
part 'tag_state.dart';

class TagBloc extends Bloc<TagEvent, TagState> {
  final supabase = Supabase.instance.client;
  TagBloc() : super(TagInitial()) {
    on<getTag>((event, emit) async {
      try {
        emit(TagLoading());
        final data = await supabase.from('tag').select();
        logger.log(data.toString());
        final List<TagModel> dataMap = [];
        for (var tag in data) {
          dataMap.add(
            TagModel.fromJson(tag),
          );
        }
        emit(TagSuccess(data: dataMap));
      } catch (e) {
        logger.log(e.toString());
        emit(TagError());
      }
    });

    on<CreateUserTag>((event, emit) async {
      try {
        emit(TagLoading());
        final Session? session = supabase.auth.currentSession;
        final ListData = [];
        for (var tag in event.tagId) {
          ListData.add({"user_id": session?.user.id, "tag_id": tag});
        }
        // logger.log(session?.user?.toString() ?? '');
        await supabase.from('minat_user').insert(ListData);

        emit(CreateSuccess());
      } catch (e) {
        logger.log(e.toString());
        emit(TagError());
      }
    });

    on<UpdateTag>((event, emit) async {
      try {
        emit(TagLoading());

        
final avatarFile = File(event.image);
final String path = await supabase.storage.from('image').upload(
      'public/avatar1.png',
      avatarFile,
      fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
    );

        emit(CreateSuccess());
      } catch (e) {
        logger.log(e.toString());
        emit(TagError());
      }
    });
  }
}
