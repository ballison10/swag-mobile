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

  /// `Swag Golf`
  String get app_name {
    return Intl.message(
      'Swag Golf',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `EXPLORE AS GUEST`
  String get explore_as_guest {
    return Intl.message(
      'EXPLORE AS GUEST',
      name: 'explore_as_guest',
      desc: '',
      args: [],
    );
  }

  /// `CREATE ACCOUNT`
  String get create_account {
    return Intl.message(
      'CREATE ACCOUNT',
      name: 'create_account',
      desc: '',
      args: [],
    );
  }

  /// `SIGN IN`
  String get sign_in {
    return Intl.message(
      'SIGN IN',
      name: 'sign_in',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgot_password {
    return Intl.message(
      'Forgot Password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Don’t have an account? *Create Account*`
  String get dont_have_account {
    return Intl.message(
      'Don’t have an account? *Create Account*',
      name: 'dont_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email address`
  String get invalid_email {
    return Intl.message(
      'Invalid email address',
      name: 'invalid_email',
      desc: '',
      args: [],
    );
  }


  /// `Password doesn’t meet requirements. Min. 8 characters, 1 uppercase, 1 number & 1 symbol`
  String get invalid_password {
    return Intl.message(
      'Password doesn’t meet requirements. Min. 8 characters, 1 uppercase, 1 number & 1 symbol',
      name: 'invalid_password',
      desc: '',
      args: [],
    );
  }

  /// `Password doesn’t match`
  String get no_match_password {
    return Intl.message(
      'Password doesn’t match',
      name: 'no_match_password',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get new_password {
    return Intl.message(
      'New Password',
      name: 'new_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirm_password {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Please enter and confirm your new password below.`
  String get reset_password_description {
    return Intl.message(
      'Please enter and confirm your new password below.',
      name: 'reset_password_description',
      desc: '',
      args: [],
    );
  }

  /// `FINISH`
  String get finish_btn {
    return Intl.message(
      'FINISH',
      name: 'finish_btn',
      desc: '',
      args: [],
    );
  }

  /// `Please check your email and enter your six digit code below.`
  String get forgot_password_code_description {
    return Intl.message(
      'Please check your email and enter your six digit code below.',
      name: 'forgot_password_code_description',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email to reset your password.`
  String get forgot_password_email_description {
    return Intl.message(
      'Enter your email to reset your password.',
      name: 'forgot_password_email_description',
      desc: '',
      args: [],
    );
  }

  /// `Code`
  String get code {
    return Intl.message(
      'Code',
      name: 'code',
      desc: '',
      args: [],
    );
  }

  /// `RESET PASSWORD`
  String get reset_password_btn {
    return Intl.message(
      'RESET PASSWORD',
      name: 'reset_password_btn',
      desc: '',
      args: [],
    );
  }

  /// `Didn’t get an email? *Resend Email*`
  String get resend_email {
    return Intl.message(
      'Didn’t get an email? *Resend Email*',
      name: 'resend_email',
      desc: '',
      args: [],
    );
  }

  /// `WELCOME @MRDOUG`
  String get popup_title {
    return Intl.message(
      'WELCOME @MRDOUG',
      name: 'popup_title',
      desc: '',
      args: [],
    );
  }

  /// `It looks like you have an account on swag.golf. Would you like to import your transaction history? You will be able to customize this later.`
  String get popup_description {
    return Intl.message(
      'It looks like you have an account on swag.golf. Would you like to import your transaction history? You will be able to customize this later.',
      name: 'popup_description',
      desc: '',
      args: [],
    );
  }

  /// `YES, IMPORT MY INFO`
  String get popup_btn_yes {
    return Intl.message(
      'YES, IMPORT MY INFO',
      name: 'popup_btn_yes',
      desc: '',
      args: [],
    );
  }

  /// `NO, I'LL DO THIS LATER`
  String get popup_btn_no {
    return Intl.message(
      'NO, I\'LL DO THIS LATER',
      name: 'popup_btn_no',
      desc: '',
      args: [],
    );
  }


  /// `Incorrect email or password. Please try again`
  String get incorrect_email_or_password {
    return Intl.message(
      'Incorrect email or password. Please try again',
      name: 'incorrect_email_or_password',
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
