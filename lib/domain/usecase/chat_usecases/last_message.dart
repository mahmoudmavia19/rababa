import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:rababa/domain/repository/repository.dart';
import 'package:rababa/domain/usecase/base_usecase.dart';

import '../../../data/network/failure.dart';

class LastMessageUseCase extends BaseUseCase<String,Stream<DocumentSnapshot<Map<String, dynamic>>>?>{
  Repository repository ;


  LastMessageUseCase(this.repository);

  @override
  Future<Either<Failure, Stream<DocumentSnapshot<Map<String, dynamic>>>?>> execute(String input) async{
   return await repository.lastMessage(input) ;
  }

}