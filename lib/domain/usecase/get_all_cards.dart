import 'package:dartz/dartz.dart';
import 'package:rababa/data/model/card_model.dart';
import 'package:rababa/data/network/failure.dart';
import 'package:rababa/domain/repository/repository.dart';
import 'package:rababa/domain/usecase/base_usecase.dart';

class GetAllCardsUseCase extends BaseUseCase<void,List<CardModel>?>{
  Repository repository;


  GetAllCardsUseCase(this.repository);

  @override
  Future<Either<Failure, List<CardModel>?>> execute(void input) async{
    return await repository.getAllCards();
  }

}