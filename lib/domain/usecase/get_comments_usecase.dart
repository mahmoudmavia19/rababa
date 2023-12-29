import 'package:dartz/dartz.dart';
import 'package:rababa/data/model/post_model.dart';
import 'package:rababa/data/network/failure.dart';
import 'package:rababa/domain/repository/repository.dart';
import 'package:rababa/domain/usecase/base_usecase.dart';

class GetCommentsUseCase extends BaseUseCase<PostModel, List<Map<String,dynamic>>?>{
  Repository repository;

  GetCommentsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Map<String,dynamic>>?>>  execute(PostModel input) async{
    return await repository.getComments(input);
  }

}