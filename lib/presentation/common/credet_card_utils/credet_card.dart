import 'package:flutter/material.dart';
import 'package:rababa/presentation/resources/assets_manager.dart';

class CreditCardUtils {

  static Widget cardIcon(CreditCardType cardType){
    switch(cardType){
      case CreditCardType.visa:
       return Image.asset(AppIcons.visa,width: 25,height: 25,) ;
      case CreditCardType.mastercard:
        return Image.asset(AppIcons.masterCard,width: 25,height: 25,) ;
      case CreditCardType.unknown:
        return const Icon(Icons.credit_card,size: 25) ;
    }

  }

}

enum CreditCardType {
  visa,
  mastercard,
  unknown
}
