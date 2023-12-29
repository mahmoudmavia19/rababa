import 'package:dartz/dartz.dart';
import 'package:rababa/data/network/failure.dart';
import 'package:rababa/domain/repository/repository.dart';
import 'package:rababa/domain/usecase/base_usecase.dart';

class GetChatUsersUnfollowUseCase extends BaseUseCase<void,List<String>>{
  final Repository repository ;

  GetChatUsersUnfollowUseCase(this.repository);

  @override
  Future<Either<Failure, List<String>>> execute(void input) async{
    return await repository.getListOfChatUsersUnFollow();
  }

}