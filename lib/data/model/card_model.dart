import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';


part 'card_model.g.dart';
@JsonSerializable()
class CardModel extends Equatable {

  String cardNumber ;
  String cardName ;
  String cardExMonth ;
  String cardExYear ;

  CardModel(this.cardNumber, this.cardName, this.cardExMonth, this.cardExYear);

factory CardModel.fromJson(Map<String, dynamic> json) => _$CardModelFromJson(json);

Map<String, dynamic> toJson() => _$CardModelToJson(this);

  @override
  List<Object?> get props =>[
    cardNumber,
    cardName,
    cardExMonth,
    cardExYear
  ];
}