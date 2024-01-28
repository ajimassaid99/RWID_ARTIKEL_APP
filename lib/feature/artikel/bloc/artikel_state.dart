part of 'artikel_bloc.dart';

abstract class ArtikelState extends Equatable {
  const ArtikelState();
  
  @override
  List<Object> get props => [];
}

class ArtikelInitial extends ArtikelState {}
class ArtikelFailed extends ArtikelState {}
class ArtikelLoading extends ArtikelState {}
class ArtikelCreateSucces extends ArtikelState {}



class ArtikelSuccess extends ArtikelState {
  final List<ArtikelModel> data;

  const ArtikelSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class ArtikelDetailSuccess extends ArtikelState {
  final ArtikelModel data;

  const ArtikelDetailSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

