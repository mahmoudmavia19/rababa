import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:rababa/domain/repository/repository.dart';
import 'package:rababa/domain/usecase/base_usecase.dart';
import '../../../data/network/failure.dart';

class UnSeenUseCase extends BaseUseCase<String,Stream<QuerySnapshot<Map<String, dynamic>>>?>{
  Repository repository ;


  UnSeenUseCase(this.repository);

  @override
  Future<Either<Failure,Stream<QuerySnapshot<Map<String, dynamic>>>?>> execute(String input)async {
    return repository.unSeen(input);
  }

}