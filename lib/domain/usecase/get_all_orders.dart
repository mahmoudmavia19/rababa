

import 'package:dartz/dartz.dart';
import 'package:rababa/data/model/order_model.dart';
import 'package:rababa/data/network/failure.dart';
import 'package:rababa/domain/repository/repository.dart';
import 'package:rababa/domain/usecase/base_usecase.dart';

class GetAllOrdersUseCase extends BaseUseCase<void,List<OrderModel>> {
  Repository repository ;

  GetAllOrdersUseCase(this.repository);

  @override
  Future<Either<Failure, List<OrderModel>>> execute(void input) async{
    return await repository.getAllOrders() ;
  }

}