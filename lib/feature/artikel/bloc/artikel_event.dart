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