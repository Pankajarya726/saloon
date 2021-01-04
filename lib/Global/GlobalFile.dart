class GlobalFile
{
  static getCaptialize(String s) {
    s=GlobalFile.getStringValue(s);
    try{
      if(s.length>0)
      {

        return '${s[0].toUpperCase()}${s.substring(1)} ';
      }else
      {
        return "";
      }
    }catch(e)
    {
      return "";
    }

  }


  static String getStringValue(String set) {

    if (set.toString().toLowerCase() == "null") {
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