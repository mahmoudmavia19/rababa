import 'package:dartz/dartz.dart';
import 'package:rababa/data/network/failure.dart';
import 'package:rababa/domain/repository/repository.dart';
import 'package:rababa/domain/usecase/base_usecase.dart';

class BlockUserUseCase extends BaseUseCase<BlockUserUseCaseInput,void>{
  Repository repository ;

  BlockUserUseCase(this.repository);

  @override
  Future<Either<Failure, void>> execute(BlockUserUseCaseInput input) async{
    if(input.isBlocked)
      {
        return await repository.blockUser(input.userId) ;
      }else {
      return await repository.unblockUser(input.userId) ;
    }
  }
}
class BlockUserUseCaseInput {
  String userId ;
  bool isBlocked ;

  BlockUserUseCaseInput(this.userId, this.isBlocked);

}