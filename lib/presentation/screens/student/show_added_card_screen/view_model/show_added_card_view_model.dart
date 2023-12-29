import 'dart:async';

import 'package:credit_card_validator/credit_card_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/data/model/card_model.dart';
import 'package:rababa/domain/usecase/get_all_cards.dart';
import 'package:rababa/presentation/base/base_viewmodel.dart';
import 'package:rababa/presentation/common/credet_card_utils/credet_card.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rxdart/rxdart.dart';

class ShowAddCardViewModel extends BaseViewModel
    with ShowAddCardViewModelInput, ShowAddCardViewModelOutput {
  final StreamController<List<CardModel>> _cardsStreamController =
      BehaviorSubject<List<CardModel>>();

  GetAllCardsUseCase getAllCardsUseCase;

  ShowAddCardViewModel(this.getAllCardsUseCase);

  @override
  void start() {
    getAllCards();
  }

  @override
  Sink<List<CardModel>?> get inputCards => _cardsStreamController.sink;

  @override
  Stream<List<CardModel>> get outputCards =>
      _cardsStreamController.stream.map((event) => event);

  @override
  getAllCards() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await getAllCardsUseCase.execute(AppConstant.nullVoid())).fold((failure) {
      inputState.add(
          ErrorState(StateRendererType.fullScreenErrorState, failure.message));
    }, (data) {
      print('cards count is  ${data!.length}') ;
      inputCards.add(data);
      if (data == [] || data.isEmpty) {
        inputState.add(EmptyState(AppStrings.emptyContent));
      } else {
        inputState.add(ContentState());
      }
    });
  }
  @override
  getAllCardsWithOutState() async {
    (await getAllCardsUseCase.execute(AppConstant.nullVoid())).fold((failure) {
    }, (data) {
      print('cards count is  ${data!.length}') ;
      inputCards.add(data);
    });
  }

  @override
  Widget showCardIcon(String number) {
    var type =  CreditCardValidator().validateCCNum(number).ccType;
    print(type);
       return
       type.toString()==CreditCardType.visa.toString()?
       CreditCardUtils.cardIcon(CreditCardType.visa) :
       type.toString()==CreditCardType.mastercard.toString()?
       CreditCardUtils.cardIcon(CreditCardType.mastercard): CreditCardUtils.cardIcon(CreditCardType.unknown) ;
  }
}

abstract class ShowAddCardViewModelOutput {
  Stream<List<CardModel>> get outputCards;
  Widget showCardIcon(String number);
}

abstract class ShowAddCardViewModelInput {
  getAllCards();
  getAllCardsWithOutState();
  Sink<List<CardModel>?> get inputCards;
}
