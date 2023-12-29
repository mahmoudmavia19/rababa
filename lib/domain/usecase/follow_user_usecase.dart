import 'package:dartz/dartz.dart';
import 'package:rababa/data/network/failure.dart';
import 'package:rababa/domain/repository/repository.dart';
import 'package:rababa/domain/usecase/base_usecase.dart';

class FollowUseCase extends BaseUseCase<FollowUseCaseInput,void>{
  Repository repository ;

  FollowUseCase(this.repository);

  @override
  Future<Either<Failure, void>> execute(input) async{
  if(input.follow)
    {
      print('Foooooooooooollowww') ;
    return repository.followUser(input.userId);

    }else
      {
        print('uuuuuuuuuuuuunFoooooooooooollowww') ;
        return repository.unfollowUser(input.userId);
      }
  }


}

class FollowUseCaseInput {
  bool follow  ;
  String userId ;

  FollowUseCaseInput(this.follow, this.userId);
}