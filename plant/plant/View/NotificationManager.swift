import Foundation
import UserNotifications

final class NotificationManager {
    static let shared = NotificationManager()
    private init() {}

    private let center = UNUserNotificationCenter.current()
    private let reminderID = "dailyWaterReminder"

    func requestPermission() {
        center.requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }
    }

    // Real mode: every day at 9:00 AM.
    // Test mode: once, one minute from now.
    func scheduleDailyReminder(hour: Int = 9, minute: Int = 0, testMode: Bool = false) {
        let content = UNMutableNotificationContent()
        content.body = "Hey! let's water your plant"
        content.sound = .default

        let trigger: UNNotificationTrigger
        if testMode {
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: false)
        } else {
            var time = DateComponents()
            time.hour = hour
            time.minute = minute
            trigger = UNCalendarNotificationTrigger(dateMatching: time, repeats: true)
        }

        let request = UNNotificationRequest(identifier: reminderID, content: content, trigger: trigger)
        center.add(request)
    }

    func cancelDailyReminder() {
        center.removePendingNotificationRequests(withIdentifiers: [reminderID])
    }

    func removeAllReminders() {
        center.removeAllPendingNotificationRequests()
    }
}
