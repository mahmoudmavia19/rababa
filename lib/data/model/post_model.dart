import 'package:json_annotation/json_annotation.dart';
 import 'package:equatable/equatable.dart';

part 'post_model.g.dart';
@JsonSerializable(explicitToJson: true)
class PostModel extends Equatable {
  String?  id ;
  String?  author ;
  String? title ;
  String? postImg;
  String? postVideo;
  String? fileName;
  List<String> likes ;
  bool? isLiked ;
  DateTime? date ;
  List<String>? comments ;

  PostModel(this.id, this.author, this.title, this.postImg, this.postVideo,
      this.likes, this.isLiked, this.date, this.comments , this.fileName);


  @override
   List<Object?> get props => [
      id,
    author,
      title,
      postImg,
      postVideo,
      likes,
      isLiked,
      date,
    fileName,
      comments
  ];

  factory PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json)..isLiked = false;

  Map<String, dynamic> toJson() => _$PostModelToJson(this);

}

@JsonSerializable(explicitToJson: true)
class CommentModel extends Equatable {
  String? id ;
  String? userId ;
  String? comment ;
  DateTime? date ;


  CommentModel(this.id,this.userId ,this.comment, this.date);


  factory CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
  @override
  List<Object?> get props => [
     id,
    userId,
     comment,
     date
  ];


}