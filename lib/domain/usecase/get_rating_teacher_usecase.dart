import 'package:dartz/dartz.dart';
import 'package:rababa/data/network/failure.dart';
import 'package:rababa/domain/repository/repository.dart';
import 'package:rababa/domain/usecase/base_usecase.dart';

import '../../data/model/rate_model.dart';

class GetRatingTeacherUseCase extends BaseUseCase<String,List<RateModel>>{
  Repository repository;

  GetRatingTeacherUseCase(this.repository);

  @override
  Future<Either<Failure, List<RateModel>>> execute(String input) async{
    return await repository.getRatingTeacher(input)!;
  }

}