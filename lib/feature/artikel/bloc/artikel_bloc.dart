import 'dart:io';

import 'package:artikel_aplication/feature/artikel/model/artikel_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:developer' as logger show log;

part 'artikel_event.dart';
part 'artikel_state.dart';

class ArtikelBloc extends Bloc<ArtikelEvent, ArtikelState> {
  final supabase = SupabaseClient('https://zyjhweeksojjyuiywhmm.supabase.co',
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp5amh3ZWVrc29qanl1aXl3aG1tIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcwMzU5ODExNCwiZXhwIjoyMDE5MTc0MTE0fQ.QSdlUuA8G10-_zMltuXiqcupcE4eqKkuscDs2NaAwF0');

  ArtikelBloc() : super(ArtikelInitial()) {
    on<GetArtikel>((event, emit) async {
      try {
        emit(ArtikelLoading());
        final data =
            await supabase.from('artikel').select('*, author:users(*)');
        print(data);

        final List<ArtikelModel> dataMap = [];
        for (var artikel in data) {
          dataMap.add(
            ArtikelModel.fromJson(artikel),
          );
        }
        emit(ArtikelSuccess(data: dataMap));
      } catch (e) {
        logger.log(e.toString());
        emit(ArtikelFailed());
      }
    });
    on<GetDetailArtikel>((event, emit) async {
      try {
        emit(ArtikelLoading());
        final Session? session = supabase.auth.currentSession;
        final data =
            await supabase.from('artikel').select('*, author:users(*)').eq('id', event.id);
            
        final user = await supabase
            .from('users')
            .select()
            .eq('user_id', event.userId);
        final userRead = await supabase.from('user_reads').select('*').eq('artikel_id', event.id).eq("user_id",user[0]['id']);
        if(userRead.isEmpty){
          await supabase.from('user_reads').insert({"user_id":user[0]['id'], 'artikel_id':event.id});
        }

        final ArtikelModel artikel = ArtikelModel.fromJson(data[0]);
        emit(ArtikelDetailSuccess(data: artikel));
      } catch (e) {
        logger.log(e.toString());
        emit(ArtikelFailed());
      }
    });
    on<CreateArtikel>((event, emit) async {
      try {
        emit(ArtikelLoading());
        final user = await supabase
            .from('users')
            .select('id')
            .eq('user_id', event.userId);
        final String path = await supabase.storage.from('artikel').upload(
              '${event.title}-${event.userId}',
              event.image,
              fileOptions:
                  const FileOptions(cacheControl: '3600', upsert: false),
            );

        final String publicUrl = supabase.storage
            .from('artikel')
            .getPublicUrl('${event.title}-${event.userId}');

            print("Coba URL $publicUrl");
        if (path != null) {
          await supabase.from('artikel').insert({
            "title": event.title,
            "content": event.content,
            "author": user[0]['id'],
            "url_image": publicUrl,
            "tag": event.tag
          });
        }

        emit(ArtikelCreateSucces());
      } catch (e) {
        logger.log(e.toString());
        emit(ArtikelFailed());
      }
    });
  }
}
