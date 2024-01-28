part of 'bookmark_bloc.dart';

abstract class BookmarkEvent extends Equatable {
  const BookmarkEvent();

  @override
  List<Object> get props => [];
}

class GetBookmark extends BookmarkEvent{
  const GetBookmark();
  
  @override
  List<Object> get props => [];
}
class InsertBookmark extends BookmarkEvent{
  final int artikelId;
  const InsertBookmark({required this.artikelId});
  
  @override
  List<Object> get props => [artikelId];
}
class DeleteBookmark extends BookmarkEvent{
  final int artikelId;
  const DeleteBookmark({required this.artikelId});
  
  @override
  List<Object> get props => [artikelId];
}