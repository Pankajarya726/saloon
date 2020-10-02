class GlobalFile
{
  static getCaptialize(String s) {
    s=GlobalFile.getStringValue(s);
    return '${s[0].toUpperCase()}${s.substring(1)} ';
  }


  static String getStringValue(String set) {
    if (set.toLowerCase() == "null") {
      set = "";
    }
    return set;
  }


}