import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:rababa/data/model/user_model.dart';
import 'package:rababa/data/network/failure.dart';
import 'package:rababa/domain/repository/repository.dart';
import 'package:rababa/domain/usecase/base_usecase.dart';

class GetProfileUseCase extends BaseUseCase<void, Stream<DocumentSnapshot<Map<String, dynamic>>>> {

  final Repository _repository ;

  GetProfileUseCase(this._repository);

  @override
  Future<Either<Failure, Stream<DocumentSnapshot<Map<String, dynamic>>>>> execute(void input)   {
    return  _repository.getProfileStream() ;
  }

}