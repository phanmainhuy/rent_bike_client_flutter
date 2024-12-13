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
  String get LOGIN {
    return Intl.message(
      'Login',
      name: 'LOGIN',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get REGISTER {
    return Intl.message(
      'Register',
      name: 'REGISTER',
      desc: '',
      args: [],
    );
  }

  /// `Customer List`
  String get CUSTOMER_LIST {
    return Intl.message(
      'Customer List',
      name: 'CUSTOMER_LIST',
      desc: '',
      args: [],
    );
  }

  /// `Statistics`
  String get STATISTICS {
    return Intl.message(
      'Statistics',
      name: 'STATISTICS',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle List`
  String get VEHICLE_LIST {
    return Intl.message(
      'Vehicle List',
      name: 'VEHICLE_LIST',
      desc: '',
      args: [],
    );
  }

  /// `Rent Bike`
  String get RENT_BIKE {
    return Intl.message(
      'Rent Bike',
      name: 'RENT_BIKE',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle Fee`
  String get VEHICLE_FEE {
    return Intl.message(
      'Vehicle Fee',
      name: 'VEHICLE_FEE',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle Registration`
  String get VEHICLE_REGISTRATION {
    return Intl.message(
      'Vehicle Registration',
      name: 'VEHICLE_REGISTRATION',
      desc: '',
      args: [],
    );
  }

  /// `Customer Registration`
  String get CUSTOMER_REGISTRATION {
    return Intl.message(
      'Customer Registration',
      name: 'CUSTOMER_REGISTRATION',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle Rental Registration`
  String get VEHICLE_RENTAL_REGISTRATION {
    return Intl.message(
      'Vehicle Rental Registration',
      name: 'VEHICLE_RENTAL_REGISTRATION',
      desc: '',
      args: [],
    );
  }

  /// `Repair Vehicle Registration`
  String get REPAIR_VEHICLE_REGISTRATION {
    return Intl.message(
      'Repair Vehicle Registration',
      name: 'REPAIR_VEHICLE_REGISTRATION',
      desc: '',
      args: [],
    );
  }

  /// `Event Calendar`
  String get EVENT_CALENDAR {
    return Intl.message(
      'Event Calendar',
      name: 'EVENT_CALENDAR',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get LOGOUT {
    return Intl.message(
      'Logout',
      name: 'LOGOUT',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get SEARCH {
    return Intl.message(
      'Search',
      name: 'SEARCH',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get NOTIFICATION {
    return Intl.message(
      'Notification',
      name: 'NOTIFICATION',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get HOME {
    return Intl.message(
      'Home',
      name: 'HOME',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get PROFILE {
    return Intl.message(
      'Profile',
      name: 'PROFILE',
      desc: '',
      args: [],
    );
  }

  /// `Home Page`
  String get HOME_PAGE {
    return Intl.message(
      'Home Page',
      name: 'HOME_PAGE',
      desc: '',
      args: [],
    );
  }

  /// `Profile Page`
  String get PROFILE_PAGE {
    return Intl.message(
      'Profile Page',
      name: 'PROFILE_PAGE',
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
      Locale.fromSubtags(languageCode: 'vn'),
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
