import 'package:dartz/dartz.dart';
import 'package:rababa/data/model/post_model.dart';
import 'package:rababa/data/network/failure.dart';
import 'package:rababa/domain/repository/repository.dart';
import 'package:rababa/domain/usecase/base_usecase.dart';

class GetAllUserPostsUseCase extends BaseUseCase<String , List<PostModel>?> {
  Repository repository ;

  GetAllUserPostsUseCase(this.repository);

  @override
  Future<Either<Failure, List<PostModel>?>> execute(String input) async{
     return await repository.getAllUserPosts(input);
  }

}