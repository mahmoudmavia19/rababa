import 'package:dartz/dartz.dart';

import 'package:rababa/data/network/failure.dart';
import 'package:rababa/domain/repository/repository.dart';

import '../../data/model/order_model.dart';
import 'base_usecase.dart';

class PayUseCase extends BaseUseCase<OrderModel,void>{
  Repository repository ;


  PayUseCase(this.repository);

  @override
  Future<Either<Failure, void>> execute(OrderModel input)async{
    return await repository.pay(input);
  }

}