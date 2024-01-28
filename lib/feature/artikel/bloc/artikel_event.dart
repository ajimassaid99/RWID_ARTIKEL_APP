part of 'artikel_bloc.dart';

abstract class ArtikelEvent extends Equatable {
  const ArtikelEvent();

  @override
  List<Object> get props => [];
}

class GetArtikel extends ArtikelEvent{
  const GetArtikel();
    @override
  List<Object> get props => [];
}
class GetDetailArtikel extends ArtikelEvent{
  final int id;
  final String userId;
  const GetDetailArtikel({required this.id, required this.userId});
    @override
  List<Object> get props => [id,userId];
}
class CreateArtikel extends ArtikelEvent{
  final int tag;
  final String title;
  final String content;
  final File image;
  final String userId;
  const CreateArtikel({required this.tag, required this.title, required this.content, required this.image, required this.userId});
    @override
  List<Object> get props => [tag,title,content,image, userId];
}