import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Notification service for AI-powered proactive alerts
class NotificationService {
  final FlutterLocalNotificationsPlugin _notifications;

  NotificationService() : _notifications = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOSSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iOSSettings,
    );

    await _notifications.initialize(settings);
  }

  /// AI-triggered notification for fitness goal progress
  Future<void> notifyFitnessGoalProgress({
    required int currentSteps,
    required int goalSteps,
  }) async {
    final percentage = (currentSteps / goalSteps * 100).toInt();
    
    if (percentage >= 80 && percentage < 100) {
      await _showNotification(
        title: 'Almost there! 💪',
        body: 'You\'re $percentage% to your step goal. Just ${goalSteps - currentSteps} more steps!',
        type: NotificationType.fitness,
      );
    } else if (percentage >= 100) {
      await _showNotification(
        title: 'Goal Crushed! 🎉',
        body: 'You hit your step goal! AI suggests: Keep the momentum with a 10-minute stretch.',
        type: NotificationType.fitness,
      );
    }
  }

  /// AI-triggered notification for budget alerts
  Future<void> notifyBudgetAlert({
    required String category,
    required double spent,
    required double limit,
  }) async {
    final percentage = (spent / limit * 100).toInt();
    
    if (percentage >= 90) {
      await _showNotification(
        title: 'Budget Alert ⚠️',
        body: 'You\'ve used $percentage% of your $category budget. AI tip: Review recent transactions.',
        type: NotificationType.finance,
      );
    }
  }

  /// AI-triggered health reminders
  Future<void> notifyHealthReminder({
    required String message,
  }) async {
    await _showNotification(
      title: 'Health Check 💊',
      body: message,
      type: NotificationType.health,
    );
  }

  /// Cross-pillar insight notification
  Future<void> notifyCrossPillarInsight({
    required String title,
    required String insight,
  }) async {
    await _showNotification(
      title: 'AI Insight: $title',
      body: insight,
      type: NotificationType.insight,
    );
  }

  Future<void> _showNotification({
    required String title,
    required String body,
    required NotificationType type,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      type.channelId,
      type.channelName,
      channelDescription: type.channelDescription,
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const iOSDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );

    await _notifications.show(
      type.hashCode,
      title,
      body,
      details,
    );
  }
}

enum NotificationType {
  fitness('fitness', 'Fitness', 'Fitness and activity notifications'),
  finance('finance', 'Finance', 'Budget and spending notifications'),
  health('health', 'Health', 'Health and appointment reminders'),
  insight('insight', 'AI Insights', 'Cross-pillar insights from AI');

  final String channelId;
  final String channelName;
  final String channelDescription;

  const NotificationType(this.channelId, this.channelName, this.channelDescription);
}

/// Provider for NotificationService
final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});
