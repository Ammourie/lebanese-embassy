import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class Utils {
  static void pushNavigateTo(context, bool withNavBar, String route,
      {arguments}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushNamed(route, arguments: arguments);
    });
  }

  static bool isImageFile(String filePath) {
    final extension = filePath.split('.').last.toLowerCase();
    const imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'];
    return imageExtensions.contains(extension);
  }
// Generic function to group a list into a map by a key
  static Map<K, List<V>> groupByGroupString<V, K>(List<V> list, K Function(V) keyFunction) {
    Map<K, List<V>> map = {};
    for (var item in list) {
      var key = keyFunction(item);
      if (!map.containsKey(key)) {
        map[key] = [];
      }
      map[key]!.add(item);
    }
    return map;
  }
  static void showToast(String message) {
    Fluttertoast.showToast(msg: message);
  }

  Map<T, List<S>> groupBy<S, T>(Iterable<S> values, T Function(S) key) {
    var map = <T, List<S>>{};
    for (var element in values) {
      (map[key(element)] ??= []).add(element);
    }
    return map;
  }

  static Future<T?> pushNewScreenWithRouteSettings<T>(
    final BuildContext context, {
    required final Widget screen,
    required final RouteSettings settings,
    bool? withNavBar,
    final PageRoute<T>? customPageRoute,
  }) {
    withNavBar ??= true;

  return  PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
      context,
      settings: settings,

      screen:  screen,

      withNavBar: withNavBar,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );


    // return Navigator.of(context, rootNavigator: !withNavBar)
    //     .push<T>(customPageRoute as Route<T>);
  }

  static void pushReplacementNavigateTo(context, String route, {arguments}) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacementNamed(route, arguments: arguments);
    });
  }

  static Future<T?> pushDynamicScreen<T>(
    BuildContext context, {
    required dynamic screen,
    bool? withNavBar,
  }) {
    if (withNavBar == null) {
      withNavBar = true;
    }
    return Navigator.of(context, rootNavigator: !withNavBar).push<T>(screen);
  }

  static void popNavigate(context, {int popsCount = 1, bool value = false}) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      for (int i = 0; i < popsCount; i++) {
        // Navigator.of(context).pop();
        PersistentNavBarNavigator.pop(context);

      }
    });
  }

  static void popNavigateToFirst(context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    });
  }

  static void clearAndPush(context, newRouteName) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(newRouteName, (route) => false);
    });
  }
  static String getDateFormated(DateTime dateTime) {
    return Intl.withLocale(
        'en', () => DateFormat('yyyy-MM-dd').format(dateTime));
  }
  static String getTimeHourMinuteFormated(DateTime dateTime) {
    return Intl.withLocale('en', () => DateFormat('HH:mm').format(dateTime));
  }

  static String getDateFromStringFormated(String dateTime) {
    List<String> data = [];
    data = dateTime.split(" ");
    if (data.length > 0) return data.first;
    return "";
  }
}
