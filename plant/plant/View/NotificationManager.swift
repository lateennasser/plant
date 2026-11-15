import Foundation
import UserNotifications

final class NotificationManager {
    static let shared = NotificationManager()
    private init() {}

    private let center = UNUserNotificationCenter.current()

    // One fixed ID for the daily reminder.
    // Scheduling again with the same ID replaces the old one, so it never duplicates.
    private let reminderID = "dailyWaterReminder"

    func requestPermission() {
        center.requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }
    }

    // One notification per day at the given time (default 9:00 AM).
    // testMode: repeats every 60 seconds instead (60 is the minimum for repeating).
    func scheduleDailyReminder(hour: Int = 9, minute: Int = 0, testMode: Bool = false) {
        let content = UNMutableNotificationContent()
        content.body = "Hey! let's water your plant"
        content.sound = .default

        let trigger: UNNotificationTrigger
        if testMode {
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
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
