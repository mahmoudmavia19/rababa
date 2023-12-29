extension CardDateFormat on String {
  String cardFormat(){
    return length == 1 ? '0$this' :
    length == 4 ? '${this[2]}${this[3]}' : this ;
  }
}

extension BoolNull on bool? {
  bool isNull()=> this == null ? false : this!;
}