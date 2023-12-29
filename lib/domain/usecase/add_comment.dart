import 'package:dartz/dartz.dart';
import 'package:rababa/data/model/post_model.dart';
import 'package:rababa/data/network/failure.dart';
import 'package:rababa/domain/repository/repository.dart';
import 'package:rababa/domain/usecase/base_usecase.dart';

class AddCommentUseCase extends BaseUseCase<AddCommentUseCaseInput , void>{
  Repository repository;


  AddCommentUseCase(this.repository);

  @override
  Future<Either<Failure, void>> execute(AddCommentUseCaseInput input)async {
   return  await repository.addComment(input.postModel,input.commentModel);
  }

}

class AddCommentUseCaseInput {
  PostModel postModel ;
  CommentModel commentModel ;

  AddCommentUseCaseInput(this.postModel, this.commentModel);
}