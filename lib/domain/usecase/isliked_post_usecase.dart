import 'package:dartz/dartz.dart';
import 'package:rababa/data/network/failure.dart';
import 'package:rababa/domain/repository/repository.dart';
import 'package:rababa/domain/usecase/base_usecase.dart';

class IsLikedUseCase extends BaseUseCase<String,bool>{
  Repository repository ;


  IsLikedUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> execute(String input) async{
    return await repository.postIsLiked(input);
  }

}