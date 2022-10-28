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

  /// `Request to API server was cancelled.`
  String get request_cancel {
    return Intl.message(
      'Request to API server was cancelled.',
      name: 'request_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Connect timeout.`
  String get connect_timeout {
    return Intl.message(
      'Connect timeout.',
      name: 'connect_timeout',
      desc: '',
      args: [],
    );
  }

  /// `Request timed out.`
  String get request_timed_out {
    return Intl.message(
      'Request timed out.',
      name: 'request_timed_out',
      desc: '',
      args: [],
    );
  }

  /// `Receive timeout`
  String get receive_timed_out {
    return Intl.message(
      'Receive timeout',
      name: 'receive_timed_out',
      desc: '',
      args: [],
    );
  }

  /// `Syntax error request`
  String get syntax_error_request {
    return Intl.message(
      'Syntax error request',
      name: 'syntax_error_request',
      desc: '',
      args: [],
    );
  }

  /// `Access denied`
  String get access_denied {
    return Intl.message(
      'Access denied',
      name: 'access_denied',
      desc: '',
      args: [],
    );
  }

  /// `The server refused to execute.`
  String get the_server_refused_to_execute {
    return Intl.message(
      'The server refused to execute.',
      name: 'the_server_refused_to_execute',
      desc: '',
      args: [],
    );
  }

  /// `Can not connect to server`
  String get can_not_connect_to_server {
    return Intl.message(
      'Can not connect to server',
      name: 'can_not_connect_to_server',
      desc: '',
      args: [],
    );
  }

  /// `Method not allowed.`
  String get method_not_allowed {
    return Intl.message(
      'Method not allowed.',
      name: 'method_not_allowed',
      desc: '',
      args: [],
    );
  }

  /// `Server internal error`
  String get server_internal_error {
    return Intl.message(
      'Server internal error',
      name: 'server_internal_error',
      desc: '',
      args: [],
    );
  }

  /// `Invalid request`
  String get invalid_request {
    return Intl.message(
      'Invalid request',
      name: 'invalid_request',
      desc: '',
      args: [],
    );
  }

  /// `The server has crashed`
  String get the_server_has_crashed {
    return Intl.message(
      'The server has crashed',
      name: 'the_server_has_crashed',
      desc: '',
      args: [],
    );
  }

  /// `Does not support HTTP protocol requests`
  String get does_not_support_HTTP_protocol_requests {
    return Intl.message(
      'Does not support HTTP protocol requests',
      name: 'does_not_support_HTTP_protocol_requests',
      desc: '',
      args: [],
    );
  }

  /// `An unknown error`
  String get an_unknown_error {
    return Intl.message(
      'An unknown error',
      name: 'an_unknown_error',
      desc: '',
      args: [],
    );
  }

  /// `No network connection`
  String get no_network_connection {
    return Intl.message(
      'No network connection',
      name: 'no_network_connection',
      desc: '',
      args: [],
    );
  }

  /// `Load fail, tap to retry`
  String get load_more_fail {
    return Intl.message(
      'Load fail, tap to retry',
      name: 'load_more_fail',
      desc: '',
      args: [],
    );
  }

  /// `Wait for loading.`
  String get load_more_wait {
    return Intl.message(
      'Wait for loading.',
      name: 'load_more_wait',
      desc: '',
      args: [],
    );
  }

  /// `Loading, wait for moment ...`
  String get load_more_wait_moment {
    return Intl.message(
      'Loading, wait for moment ...',
      name: 'load_more_wait_moment',
      desc: '',
      args: [],
    );
  }

  /// `No more data`
  String get load_more_no_more {
    return Intl.message(
      'No more data',
      name: 'load_more_no_more',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `UserName`
  String get userName {
    return Intl.message(
      'UserName',
      name: 'userName',
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

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Dim Sum`
  String get dim_sum {
    return Intl.message(
      'Dim Sum',
      name: 'dim_sum',
      desc: '',
      args: [],
    );
  }

  /// `Username and password not empty`
  String get username_and_password_not_empty {
    return Intl.message(
      'Username and password not empty',
      name: 'username_and_password_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Account has create`
  String get account_has_create {
    return Intl.message(
      'Account has create',
      name: 'account_has_create',
      desc: '',
      args: [],
    );
  }

  /// `Account create fail`
  String get account_create_fail {
    return Intl.message(
      'Account create fail',
      name: 'account_create_fail',
      desc: '',
      args: [],
    );
  }

  /// `Email wrong format`
  String get email_wrong_format {
    return Intl.message(
      'Email wrong format',
      name: 'email_wrong_format',
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
      Locale.fromSubtags(languageCode: 'vi'),
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
