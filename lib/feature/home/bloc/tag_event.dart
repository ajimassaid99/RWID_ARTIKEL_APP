part of 'tag_bloc.dart';

abstract class TagEvent extends Equatable {
  const TagEvent();

  @override
  List<Object> get props => [];
}

class getTag extends TagEvent{
  const getTag();
}

class CreateUserTag extends TagEvent{
  final List<int> tagId;
  const CreateUserTag({required this.tagId});

 @override
  List<Object> get props => [tagId];

}


class UpdateTag extends TagEvent{
  final int tagId;
  final String tagName;
  final String image;
  const UpdateTag({required this.tagId, required this.tagName, required this.image});

 @override
  List<Object> get props => [tagId,tagName];

}
