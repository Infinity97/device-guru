class Helper{

  static bool checkLengthOfStringLessThan(String string, int length){
    if(string.isEmpty) {
      return false;
    }
    if(string.length >length) {
      return false;
    }
    return true;
  }

}