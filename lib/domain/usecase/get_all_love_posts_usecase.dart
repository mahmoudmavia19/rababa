import 'package:dartz/dartz.dart';
import 'package:rababa/data/model/post_model.dart';
import 'package:rababa/data/network/failure.dart';
import 'package:rababa/domain/repository/repository.dart';
import 'package:rababa/domain/usecase/base_usecase.dart';

class GetAllLovePostsUseCase extends BaseUseCase<void,List<PostModel>?>{
  Repository repository ;

  GetAllLovePostsUseCase(this.repository);

  @override
  Future<Either<Failure, List<PostModel>?>> execute(void input) async{
    return repository.getAllLovePosts();
  }

}