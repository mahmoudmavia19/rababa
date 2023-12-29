import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/data/model/shop_model.dart';
import 'package:rababa/domain/usecase/admin_usecases/admin_add_shop_usecase.dart';
import 'package:rababa/presentation/base/base_viewmodel.dart';
import 'package:rababa/presentation/common/freezed_data_classes.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../domain/usecase/admin_usecases/delete_shop_usecase.dart';
import '../../../../../domain/usecase/admin_usecases/get_all_shops_usecase.dart';

class ShopsViewModel extends BaseViewModel with  ShopsViewModelInput , ShopsViewModelOutput {

  final StreamController<ShopModel> _shopController = BehaviorSubject<ShopModel>();
  final StreamController<List<ShopModel>> _shops = BehaviorSubject<List<ShopModel>>();

  AdminAddShopUseCase addShopUseCase ;
  GetAllShopsUseCase getAllShopsUseCase ;
  DeleteShopUseCase deleteShopUseCase ;

  ShopsViewModel(this.addShopUseCase, this.getAllShopsUseCase , this.deleteShopUseCase);

  ShopsObject _shopsObject  = ShopsObject(null,null);
   @override
  void start() {
    _shopsObject  = ShopsObject(null,null);
    shopInput.add(ShopModel(_shopsObject.id, _shopsObject.geoPoint));
    inputState.add(ContentState());
  }
  @override
  void dispose() {
    _shops.close();
    _shopController.close() ;
    super.dispose();
  }
  @override
  addShop() async{
    inputState.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    if(_shopsObject.geoPoint!=null) {
      (await addShopUseCase.execute(ShopModel(_shopsObject.id, _shopsObject.geoPoint)))
          .fold((failure){
            inputState.add(ErrorState(StateRendererType.popupErrorState, failure.message));
      },
      (r) {
            inputState.add(SuccessState(StateRendererType.fullScreenSuccessState, AppStrings.successAdd));
       });
    }
    else {
      inputState.add(ErrorState(StateRendererType.popupErrorState,AppStrings.cantEmpty));
    }
  }

  @override
  setLocation(LatLng latLng) {
    _shopsObject =  _shopsObject.copyWith(geoPoint: GeoPoint(latLng.latitude,latLng.longitude));
    shopInput.add(ShopModel(null, _shopsObject.geoPoint)) ;
  }

  @override
   Sink get shopInput => _shopController.sink;

  @override
  Stream<ShopModel> get shopOutput => _shopController.stream.map((event) => event);

  @override
  getShops()async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
      (await getAllShopsUseCase.execute(AppConstant.nullVoid()))
        .fold((failure){
    inputState.add(ErrorState(StateRendererType.popupErrorState, failure.message));
    },
    (r) {
      shopsInput.add(r);
      print('check   ${r!.length}') ;
      inputState.add(ContentState());
    });
    }

  @override
  Sink get shopsInput => _shops.sink;

  @override
  Stream<List<ShopModel>> get shopsOutput =>_shops.stream.map((event) => event);

  @override
  deleteShop(ShopModel shopModel) async{
    inputState.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    (await deleteShopUseCase.execute(shopModel))
        .fold((failure){
    inputState.add(ErrorState(StateRendererType.popupErrorState, failure.message));
    },
    (r) {
          getShops();
    inputState.add(ContentState());
    });
  }

}


abstract class ShopsViewModelOutput {
  Stream<ShopModel>  get shopOutput  ;
  Stream<List<ShopModel>>  get shopsOutput  ;
  deleteShop(ShopModel shopModel);
  addShop() ;

}

abstract class ShopsViewModelInput {

  setLocation(LatLng latLng);
  getShops();
  Sink get shopInput ;
  Sink get shopsInput ;
}