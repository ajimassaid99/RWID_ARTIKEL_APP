import 'dart:async';

import 'package:artikel_aplication/feature/bookmark/model/bookmark.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  final supabase = Supabase.instance.client;
  BookmarkBloc() : super(BookmarkInitial()) {
    on<GetBookmark>((event, emit) async {
      try {
        emit(BookmarkLoading());
        final data = await supabase.from('bookmark').select();
        print("WKWKWK $data");
        final List<BookmarkModel> dataMap = [];
        for (var bookmark in data) {
          dataMap.add(
            BookmarkModel.fromJson(bookmark),
          );
        }
        emit(BookmarkSuccess(data: dataMap));
      } catch (e) {
        emit(BookmarkError());
      }
    });
    on<InsertBookmark>((event, emit) async {
      try {
        emit(BookmarkLoading());
        final Session? session = supabase.auth.currentSession;
        final user = await supabase
            .from('users')
            .select()
            .eq('user_id', session?.user.id ?? '');
        await supabase
            .from('bookmark')
            .insert({'user_id': user[0]['id'], 'artikel_id': event.artikelId});
        add(const GetBookmark());
      } catch (e) {
        emit(BookmarkError());
      }
    });
    on<DeleteBookmark>((event, emit) async {
      try {
        emit(BookmarkLoading());
        final Session? session = supabase.auth.currentSession;
        final user = await supabase
            .from('users')
            .select()
            .eq('user_id', session?.user.id ?? '');

        final data = await supabase
            .from('bookmark')
            .delete()
            .match({'user_id': user[0]['id'], 'artikel_id': event.artikelId}).select();
        print(
            'Ini Data  artikel id ${event.artikelId} userId = ${user[0]['id']}');
        final data1 = await supabase
        .from('bookmark')
        .delete()
        .eq('user_id', user[0]['id'])
        .eq('artikel_id', event.artikelId);
        print(
            'Ini Data $data artikel id ${event.artikelId} userId = ${user[0]['id']}');
        add(const GetBookmark());
      } catch (e) {
        print(
            'Ini Data ${e.toString()}');
        emit(BookmarkError());
      }
    });
  }
}
