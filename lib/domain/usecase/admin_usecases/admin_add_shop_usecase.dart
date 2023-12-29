import 'package:dartz/dartz.dart';
import 'package:rababa/data/model/shop_model.dart';
import 'package:rababa/data/network/failure.dart';
import 'package:rababa/domain/repository/repository.dart';
import 'package:rababa/domain/usecase/base_usecase.dart';

class AdminAddShopUseCase extends BaseUseCase<ShopModel,void> {
  Repository repository ;

  AdminAddShopUseCase(this.repository);

  @override
  Future<Either<Failure, void>> execute(ShopModel input) async{
     return await repository.addShop(input);
  }
}