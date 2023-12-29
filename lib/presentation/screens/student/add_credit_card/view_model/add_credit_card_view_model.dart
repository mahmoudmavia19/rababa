import 'dart:async';
import 'package:credit_card_validator/credit_card_validator.dart';
import 'package:credit_card_validator/validation_results.dart';
import 'package:flutter/material.dart';
import 'package:rababa/data/model/card_model.dart';
import 'package:rababa/domain/usecase/add_credit_card_usecase.dart';
import 'package:rababa/presentation/base/base_viewmodel.dart';
import 'package:rababa/presentation/common/freezed_data_classes.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer.dart';
import 'package:rababa/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rababa/presentation/resources/strings_manager.dart';
import 'package:rxdart/rxdart.dart';

class AddCreditCardViewModel extends BaseViewModel with AddCreditCardViewModelInput , AddCreditCardViewModelOutput{

  final StreamController<CCNumValidationResults> _validateCreditCard = BehaviorSubject<CCNumValidationResults>();
  final StreamController<String> monthCon = BehaviorSubject<String>();
  final StreamController<String> yearCon = BehaviorSubject<String>();

  CardObject  cardObject = CardObject('', '', '', '') ;

  AddCreditCardUseCase addCreditCardUseCase ;
  AddCreditCardViewModel(this.addCreditCardUseCase);

  @override
  void start() {
    inputState.add(ContentState());
   }
   @override
  void dispose() {
     _validateCreditCard.close() ;
     monthCon.close() ;
     yearCon.close() ;
    super.dispose();
  }

  @override
   Sink get cardInput =>_validateCreditCard.sink;

  @override
   Stream<CCNumValidationResults> get cardOutput => _validateCreditCard.stream.map((event) => event) ;

  @override
  List<int> getAllMonths() {
   return [1,2,3,4,5,6,7,8,9,10,11,12] ;
  }

  @override
  List<int> getAllYears() {
    return [2023,2024,2025,2026,2027,2028,2029,2030,2031,2032,2033,2034,2035,2036,2037,2038,2039,2040] ;
  }

  @override
  setCreditCardNumber(String number) {
    cardObject = cardObject.copyWith(cardNumber: number) ;
     cardInput.add(CreditCardValidator().validateCCNum(number));
     print(cardObject.cardNumber) ;
     print(cardObject.cardNumber?.length) ;

  }

  @override
  addCreditCard()async{
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    if(validateNotEmpty()) {
      if(cardObject.cardNumber?.length==19) {
        (await addCreditCardUseCase.execute(
        CardModel(cardObject.cardNumber!,
            cardObject.cardName!,
            cardObject.cardExMonth!,
          cardObject.cardExYear!)))
        .fold((failure) {
    inputState
        .add(ErrorState(StateRendererType.popupErrorState, failure.message));
    }, (data) {
    inputState.add(SuccessState(StateRendererType.fullScreenSuccessState, AppStrings.successAdd));
    });
      }
      else
        {
          inputState
              .add(ErrorState(StateRendererType.popupErrorState, 'رقم البطاقة يجب ان يكون 16 رقم'));
        }
    }
    else
      {
        inputState
            .add(ErrorState(StateRendererType.popupErrorState, AppStrings.cantEmpty));
      }
  }

  @override
  setCardName(String name) {
    cardObject = cardObject.copyWith(cardName: name) ;
  }

  @override
  setMonth(String month) {
    cardObject = cardObject.copyWith(cardExMonth: month) ;
  }

  @override
  setYear(String year) {
    cardObject = cardObject.copyWith(cardExYear: year) ;
  }

  @override
  bool validateNotEmpty() {
    return cardObject.cardExMonth != ''
    && cardObject.cardName !=''
    && cardObject.cardNumber !=''
    && cardObject.cardExYear !='';
  }


}

abstract class AddCreditCardViewModelOutput {

  Stream<CCNumValidationResults> get cardOutput;
  getAllMonths() ;
  getAllYears() ;

}

abstract class AddCreditCardViewModelInput {
  setCreditCardNumber(String number);
  addCreditCard();
  setCardName(String name);
  setMonth(String month);
  setYear(String year);
  bool validateNotEmpty();
  Sink get cardInput ;
}