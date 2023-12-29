import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:rababa/data/model/chat_model.dart';
import 'package:rababa/domain/repository/repository.dart';
import 'package:rababa/domain/usecase/base_usecase.dart';

import '../../../data/network/failure.dart';

class GetAllChatUseCase extends BaseUseCase<String,Stream<QuerySnapshot<Map<String, dynamic>>>?>{
  Repository repository ;


  GetAllChatUseCase(this.repository);

  @override
  Future<Either<Failure,Stream<QuerySnapshot<Map<String, dynamic>>>?>> execute(String input)async {
    return repository.chat(input);
  }

}