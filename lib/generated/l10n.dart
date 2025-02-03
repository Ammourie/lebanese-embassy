// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `register`
  String get register {
    return Intl.message(
      'register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection`
  String get noInternetConnection {
    return Intl.message(
      'No internet connection',
      name: 'noInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `yallacome`
  String get appName {
    return Intl.message(
      'yallacome',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `you are using offline mode`
  String get offlineMode {
    return Intl.message(
      'you are using offline mode',
      name: 'offlineMode',
      desc: '',
      args: [],
    );
  }

  /// `offline`
  String get offline {
    return Intl.message(
      'offline',
      name: 'offline',
      desc: '',
      args: [],
    );
  }

  /// `you are using online mode`
  String get onlineMode {
    return Intl.message(
      'you are using online mode',
      name: 'onlineMode',
      desc: '',
      args: [],
    );
  }

  /// `online`
  String get online {
    return Intl.message(
      'online',
      name: 'online',
      desc: '',
      args: [],
    );
  }

  /// `not valid`
  String get validationMessage {
    return Intl.message(
      'not valid',
      name: 'validationMessage',
      desc: '',
      args: [],
    );
  }

  /// `user name`
  String get userName {
    return Intl.message(
      'user name',
      name: 'userName',
      desc: '',
      args: [],
    );
  }

  /// `password`
  String get password {
    return Intl.message(
      'password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `todo : `
  String get todo {
    return Intl.message(
      'todo : ',
      name: 'todo',
      desc: '',
      args: [],
    );
  }

  /// `is completed : `
  String get isCompleted {
    return Intl.message(
      'is completed : ',
      name: 'isCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `reload`
  String get reload {
    return Intl.message(
      'reload',
      name: 'reload',
      desc: '',
      args: [],
    );
  }

  /// `Press Twice To Exit`
  String get pressTwiceToExit {
    return Intl.message(
      'Press Twice To Exit',
      name: 'pressTwiceToExit',
      desc: '',
      args: [],
    );
  }

  /// `يا مرحبا ! سجل حساب جديد`
  String get registerWelcomeMessage {
    return Intl.message(
      'يا مرحبا ! سجل حساب جديد',
      name: 'registerWelcomeMessage',
      desc: '',
      args: [],
    );
  }

  /// `يا مرحبا ! سجل دخول`
  String get loginWelcomeMessage {
    return Intl.message(
      'يا مرحبا ! سجل دخول',
      name: 'loginWelcomeMessage',
      desc: '',
      args: [],
    );
  }

  /// `نسيت كلمة المرور؟`
  String get forgotPassword {
    return Intl.message(
      'نسيت كلمة المرور؟',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `أو`
  String get or {
    return Intl.message(
      'أو',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `تأكيد كلمة السر`
  String get confirmPassword {
    return Intl.message(
      'تأكيد كلمة السر',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `بريد الكتروني`
  String get email {
    return Intl.message(
      'بريد الكتروني',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `ادخل {p} هنا `
  String enterHere(Object p) {
    return Intl.message(
      'ادخل $p هنا ',
      name: 'enterHere',
      desc: '',
      args: [p],
    );
  }

  /// `male `
  String get male {
    return Intl.message(
      'male ',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `female `
  String get female {
    return Intl.message(
      'female ',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `phoneNumber ErrorValidationMessage `
  String get phoneNumberErrorValidationMessage {
    return Intl.message(
      'phoneNumber ErrorValidationMessage ',
      name: 'phoneNumberErrorValidationMessage',
      desc: '',
      args: [],
    );
  }

  /// `gender `
  String get gender {
    return Intl.message(
      'gender ',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `phoneNumber `
  String get phoneNumber {
    return Intl.message(
      'phoneNumber ',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `أوافق على الشروط والأحكام `
  String get aggreement {
    return Intl.message(
      'أوافق على الشروط والأحكام ',
      name: 'aggreement',
      desc: '',
      args: [],
    );
  }

  /// `didnotReceiveCode `
  String get didnotReceiveCode {
    return Intl.message(
      'didnotReceiveCode ',
      name: 'didnotReceiveCode',
      desc: '',
      args: [],
    );
  }

  /// `resend `
  String get resend {
    return Intl.message(
      'resend ',
      name: 'resend',
      desc: '',
      args: [],
    );
  }

  /// `verfy `
  String get verfy {
    return Intl.message(
      'verfy ',
      name: 'verfy',
      desc: '',
      args: [],
    );
  }

  /// `الرجاء إدخال الكود الذي أرسلناه لرقمك `
  String get verificationTitle {
    return Intl.message(
      'الرجاء إدخال الكود الذي أرسلناه لرقمك ',
      name: 'verificationTitle',
      desc: '',
      args: [],
    );
  }

  /// `الرجاء إدخال كلمة السر الجديدة `
  String get newPasswordTitle {
    return Intl.message(
      'الرجاء إدخال كلمة السر الجديدة ',
      name: 'newPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `فعاليات `
  String get events {
    return Intl.message(
      'فعاليات ',
      name: 'events',
      desc: '',
      args: [],
    );
  }

  /// `منشآت`
  String get facilities {
    return Intl.message(
      'منشآت',
      name: 'facilities',
      desc: '',
      args: [],
    );
  }

  /// `back`
  String get back {
    return Intl.message(
      'back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `تغيير كلمة المرور`
  String get changePassword {
    return Intl.message(
      'تغيير كلمة المرور',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
