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
        final data = await supabase
            .from('artikel')
            .select('*, author:users(*)');
       
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
  }
}
