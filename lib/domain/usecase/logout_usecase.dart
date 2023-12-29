import 'package:dartz/dartz.dart';

import 'package:rababa/data/network/failure.dart';
import 'package:rababa/domain/repository/repository.dart';

import 'base_usecase.dart';

class LogoutUseCase extends BaseUseCase<void,void>{

  Repository repository ;

  LogoutUseCase(this.repository);

  @override
  Future<Either<Failure, void>> execute(void input) async{
    return await repository.logout();
  }

}