class Validators {
  static final RegExp _emailRegExp = RegExp(
    // r'^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$',
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^.{6,26}$',
  );

  static final RegExp _nameRegExpText =
      RegExp(r'^[a-zA-Z \u00E4\u00F6\u00FC\u00C4\u00D6\u00DC\u00df]*$');

  static final RegExp _fullNameRegExp = RegExp(r'^(?!\s*$).+ (?!\s*$).+');

  static isNotEmptyString(String string) {
    return string.trim() != "";
  }

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static hasCharacters(String text) {
    text = text.replaceAll(" ", "");
    return text.length > 0;
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }

  static isValidFirstName(String name) {
    return !_nameRegExpText.hasMatch(name);
  }

  static isValidFullName(String name) {
    return _fullNameRegExp.hasMatch(name);
  }

  static isValidConfirmPassword(String password, String confirmPassword) {
    return (password == confirmPassword);
  }
}
