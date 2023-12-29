import 'package:dartz/dartz.dart';
import 'package:rababa/data/model/user_model.dart';
import 'package:rababa/data/network/failure.dart';
import 'package:rababa/data/network/requests.dart';
import 'package:rababa/domain/repository/repository.dart';
import 'package:rababa/domain/usecase/base_usecase.dart';

class RegisterUseCase extends BaseUseCase<RegisterRequest,UserModel> {
  final Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, UserModel>> execute(RegisterRequest input) async{
   return await _repository.register(input);
  }

}
