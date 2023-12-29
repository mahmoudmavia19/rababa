import 'package:dartz/dartz.dart';
import 'package:rababa/data/model/user_model.dart';
import 'package:rababa/data/network/failure.dart';
import 'package:rababa/domain/repository/repository.dart';
import 'package:rababa/domain/usecase/base_usecase.dart';

class GetListOfUsersUseCase extends BaseUseCase<List<String>,List<UserModel>>{
  Repository repository;

  GetListOfUsersUseCase(this.repository);

  @override
  Future<Either<Failure, List<UserModel>>> execute(List<String> input) async{
   return await repository.getListOfUsers(input);
  }
}