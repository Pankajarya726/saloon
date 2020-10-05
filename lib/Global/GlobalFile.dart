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
  static bool isEmail(String em) {

    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

}