

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics();

  factory AnalyticsService() => _service;

  AnalyticsService._();

  static final AnalyticsService _service = AnalyticsService._();

  static FirebaseAnalytics get instance => _service._analytics;

  static FirebaseAnalyticsObserver get observer =>
      FirebaseAnalyticsObserver(analytics: _service._analytics);

  Future<void> logLogin() async {
    return _analytics.logLogin(loginMethod: 'email');
  }

  Future<void> setUserProperties({
    String userId,
    String userRole,


  }) async {
    await _analytics.setUserId(userId);
    await _analytics.setUserProperty(
      name: 'user_role',
      value: userRole,
    );
  }

  Future<void> logLogoutPressed({
    bool isBasketEmpty = true,
  }) async {
    return _analytics.logEvent(
        name: 'logout_pressed',
        parameters:{'is_BasketEmpty': isBasketEmpty
        },
    );
  }
}