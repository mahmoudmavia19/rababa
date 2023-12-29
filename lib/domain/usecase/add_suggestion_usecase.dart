import 'package:dartz/dartz.dart';
import 'package:rababa/data/model/suggestion_model.dart';
import 'package:rababa/data/network/failure.dart';
import 'package:rababa/domain/repository/repository.dart';
import 'package:rababa/domain/usecase/base_usecase.dart';

class AddSuggestionUseCase extends BaseUseCase<SuggestionModel,void>{
  Repository repository ;

  AddSuggestionUseCase(this.repository);

  @override
  Future<Either<Failure, void>> execute(SuggestionModel input)async{
    return await repository.addSuggestion(input);
  }

}