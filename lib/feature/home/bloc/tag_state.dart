part of 'tag_bloc.dart';

abstract class TagState extends Equatable {
  const TagState();

  @override
  List<Object> get props => [];
}

class TagInitial extends TagState {}

class TagLoading extends TagState {}

class TagSuccess extends TagState {
  final List<TagModel> data;

  const TagSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class TagError extends TagState {}

class CreateSuccess extends TagState {}
