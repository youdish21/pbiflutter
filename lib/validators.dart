class Validators{
  static String validateEmail(String value){
    final reg = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if(value  == null || value.isEmpty){
      return " Email  can/'t be empty";
    }else if (!reg.hasMatch(value)){
      return'Email is not valid';
    }
    return null;
  }

  static String  validatePassword(String value){
    return value.isEmpty ? "Password can't be empty": null;
  }
}