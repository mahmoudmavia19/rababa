import 'package:dartz/dartz.dart';
import 'package:rababa/data/model/post_model.dart';
import 'package:rababa/data/network/failure.dart';
import 'package:rababa/domain/repository/repository.dart';
import 'package:rababa/domain/usecase/base_usecase.dart';

class UpdatePostUseCase extends BaseUseCase<PostModel,void>{
  Repository repository ;

  UpdatePostUseCase(this.repository);

  @override
  Future<Either<Failure, void>> execute(PostModel input)async {
    return await repository.updatePost(input);
  }

}