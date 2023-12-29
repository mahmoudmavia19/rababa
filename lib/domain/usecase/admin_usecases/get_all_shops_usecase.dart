import 'package:dartz/dartz.dart';
import 'package:rababa/data/model/shop_model.dart';
import 'package:rababa/data/network/failure.dart';
import 'package:rababa/domain/repository/repository.dart';
import 'package:rababa/domain/usecase/base_usecase.dart';

class GetAllShopsUseCase extends BaseUseCase<void,List<ShopModel>?>{
  Repository repository ;

  GetAllShopsUseCase(this.repository);

  @override
  Future<Either<Failure, List<ShopModel>?>> execute(void input)async{
    return await repository.getAllShops();
  }

}