import 'package:dartz/dartz.dart';
import 'package:rababa/data/model/user_model.dart';
import 'package:rababa/data/network/failure.dart';
import 'package:rababa/domain/repository/repository.dart';

import '../../data/model/rate_model.dart';
import 'base_usecase.dart';

class RatingTeacherUseCase extends BaseUseCase<RateModel,void>{
  Repository repository;

  RatingTeacherUseCase(this.repository);

  @override
  Future<Either<Failure, void>> execute(RateModel input) async{
    return  await repository.ratingTeacher(input);
  }

}
