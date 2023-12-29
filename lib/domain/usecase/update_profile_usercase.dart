import 'package:dartz/dartz.dart';
import 'package:rababa/data/model/user_model.dart';
import 'package:rababa/data/network/failure.dart';
import 'package:rababa/domain/repository/repository.dart';
import 'package:rababa/domain/usecase/base_usecase.dart';

class UpdateProfileUseCase extends BaseUseCase <UserModel,UserModel> {
  final Repository _repository ;

  UpdateProfileUseCase(this._repository);

  @override
  Future<Either<Failure, UserModel>> execute(UserModel input) async{
     return await _repository.updateProfile(input) ; 
  }

}