import 'package:dartz/dartz.dart';
import 'package:rababa/data/model/order_model.dart';
import 'package:rababa/data/network/failure.dart';
import 'package:rababa/domain/repository/repository.dart';
import 'package:rababa/domain/usecase/base_usecase.dart';

class GetAllPayOperationsUseCase extends BaseUseCase<void,List<OrderModel>>{
  final Repository _repository ;

  GetAllPayOperationsUseCase(this._repository);

  @override
  Future<Either<Failure, List<OrderModel>>> execute(void input) async{
    return await _repository.getAllPayOperations() ;
  }

}
