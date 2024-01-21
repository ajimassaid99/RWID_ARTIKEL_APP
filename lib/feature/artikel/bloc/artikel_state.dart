part of 'artikel_bloc.dart';

abstract class ArtikelState extends Equatable {
  const ArtikelState();
  
  @override
  List<Object> get props => [];
}

class ArtikelInitial extends ArtikelState {}
class ArtikelFailed extends ArtikelState {}
class ArtikelLoading extends ArtikelState {}



class ArtikelSuccess extends ArtikelState {
  final List<ArtikelModel> data;

  const ArtikelSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

