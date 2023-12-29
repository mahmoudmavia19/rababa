import 'package:dartz/dartz.dart';
import 'package:rababa/data/model/post_model.dart';
import 'package:rababa/data/network/failure.dart';
import 'package:rababa/domain/repository/repository.dart';
import 'package:rababa/domain/usecase/base_usecase.dart';

class LovePostUseCase extends BaseUseCase<LovePostUseCaseInput,void>{
  Repository repository ;

  LovePostUseCase(this.repository);

  @override
  Future<Either<Failure, void>> execute(LovePostUseCaseInput input) async{
   if(input.isLiked)
     {
       return repository.addLovePost(input.postModel);
     }
   else{
     return repository.removeLovePost(input.postModel);
   }
  }
}

class LovePostUseCaseInput {
  PostModel postModel ;
  bool isLiked ;

  LovePostUseCaseInput(this.postModel, this.isLiked);
}