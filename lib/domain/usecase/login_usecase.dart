import 'package:dartz/dartz.dart';
import 'package:rababa/data/network/failure.dart';
import 'package:rababa/data/network/requests.dart';
import 'package:rababa/domain/repository/repository.dart';
import 'package:rababa/domain/usecase/base_usecase.dart';

class LoginUseCase extends BaseUseCase <LoginRequest , bool> {

  final Repository _repository ;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> execute(LoginRequest input) async{
    return await _repository.login(input) ;
  }

}