import 'package:dartz/dartz.dart';
import 'package:rababa/data/model/post_model.dart';
import 'package:rababa/data/network/failure.dart';
import 'package:rababa/domain/repository/repository.dart';
import 'package:rababa/domain/usecase/base_usecase.dart';

class CreatePostUseCase extends BaseUseCase<PostModel,PostModel>  {
  Repository repository ;

  CreatePostUseCase(this.repository);

  @override
  Future<Either<Failure, PostModel>> execute(PostModel input) async{
   return await repository.createPost(input) ;
  }

}