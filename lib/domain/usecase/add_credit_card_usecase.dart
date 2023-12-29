import 'package:dartz/dartz.dart';
import 'package:rababa/data/model/card_model.dart';
import 'package:rababa/data/network/failure.dart';
import 'package:rababa/domain/repository/repository.dart';
import 'package:rababa/domain/usecase/base_usecase.dart';

class  AddCreditCardUseCase extends BaseUseCase<CardModel,void> {

  Repository repository;

  AddCreditCardUseCase(this.repository);

  @override
  Future<Either<Failure, void>> execute(CardModel input) async{
    return repository.addCreditCard(input);
  }
}