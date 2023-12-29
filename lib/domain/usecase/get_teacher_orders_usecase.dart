import 'package:dartz/dartz.dart';
import 'package:rababa/data/model/order_model.dart';
import 'package:rababa/data/network/failure.dart';
import 'package:rababa/domain/repository/repository.dart';
import 'package:rababa/domain/usecase/base_usecase.dart';

class GetTeacherOrdersUseCase extends BaseUseCase<DateTime,List<OrderModel>>{
  final Repository _repository ;

  GetTeacherOrdersUseCase(this._repository);

  @override
  Future<Either<Failure, List<OrderModel>>> execute(DateTime input) async{
    return await _repository.getTeacherOrders(input);
  }

}