import 'package:dartz/dartz.dart';

import 'package:rababa/data/network/failure.dart';
import 'package:rababa/domain/repository/repository.dart';

import '../../data/model/user_model.dart';
import 'base_usecase.dart';

class GetAllTeacherUseCase extends BaseUseCase<void,List<UserModel>?>{
  Repository repository ;

  GetAllTeacherUseCase(this.repository);

  @override
  Future<Either<Failure, List<UserModel>?>> execute(void input) async{
    return await repository.getAllTeacher();
  }

}