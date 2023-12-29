import 'package:dartz/dartz.dart';
import 'package:rababa/data/network/failure.dart';
import 'package:rababa/domain/repository/repository.dart';
import 'package:rababa/domain/usecase/base_usecase.dart';

class ForgetPasswordUseCase extends BaseUseCase<String , void>{

  Repository repository ;

  ForgetPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, void>> execute(String input) async{
   return await repository.forgetPassword(input);
  }

}