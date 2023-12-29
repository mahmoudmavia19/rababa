import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:rababa/data/model/post_model.dart';
import 'package:rababa/data/network/failure.dart';
import 'package:rababa/domain/repository/repository.dart';
import 'package:rababa/domain/usecase/base_usecase.dart';

class ListToPostUseCase extends BaseUseCase<PostModel,Stream<DocumentSnapshot<Map<String, dynamic>>>?> {
  final Repository repository ;

  ListToPostUseCase(this.repository);

  @override
  Future<Either<Failure, Stream<DocumentSnapshot<Map<String, dynamic>>>?>> execute(PostModel input) async{
    return   await repository.listToPost(input);
  }

}