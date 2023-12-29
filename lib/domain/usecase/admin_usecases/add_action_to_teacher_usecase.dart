import 'package:dartz/dartz.dart';
import 'package:rababa/data/model/user_model.dart';
import 'package:rababa/data/network/failure.dart';
import 'package:rababa/domain/repository/repository.dart';
import 'package:rababa/domain/usecase/base_usecase.dart';

class AddActionToTeacherUseCase extends BaseUseCase<UserModel,void>{
  Repository repository ;

  AddActionToTeacherUseCase(this.repository);

  @override
  Future<Either<Failure, void>> execute(UserModel input)async {
    return  await repository.addActionToTeacher(input) ;
  }
}