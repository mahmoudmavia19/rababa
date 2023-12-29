import 'package:dartz/dartz.dart';
import 'package:rababa/data/model/user_model.dart';
import 'package:rababa/data/network/failure.dart';
import 'package:rababa/domain/repository/repository.dart';
import 'package:rababa/domain/usecase/base_usecase.dart';

class GetAllUsersUseCase extends BaseUseCase<void,List<UserModel>?>{
  Repository repository ;

  GetAllUsersUseCase(this.repository);

  @override
  Future<Either<Failure, List<UserModel>?>> execute(void input) async{
    return await repository.getAllUsers();
  }

}