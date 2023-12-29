import 'package:dartz/dartz.dart';
import 'package:rababa/data/model/chat_model.dart';
import 'package:rababa/data/network/failure.dart';
import 'package:rababa/domain/repository/repository.dart';

import '../base_usecase.dart';

class SendMessageUseCase extends BaseUseCase<SendMessageUseCaseInput,void>{
  Repository repository ;

  SendMessageUseCase(this.repository);

  @override
  Future<Either<Failure, void>> execute(SendMessageUseCaseInput input) async{
   return await repository.sendMessage(input.chatModel!, input.antherId!) ;  
  }

}

class SendMessageUseCaseInput {
  String? antherId ;
  ChatModel? chatModel ;

  SendMessageUseCaseInput(this.antherId, this.chatModel);

}