import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()

    func requestPermission() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }
    }

    func scheduleReminder(for plant: Plant) {
        let content = UNMutableNotificationContent()
        content.title = "Time to water \(plant.name) 💧"
        content.body = "\(plant.water.rawValue) in the \(plant.room.rawValue)"
        content.sound = .default

        let seconds = Double(plant.wateringDays.days) * 24 * 60 * 60
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: true)

        let request = UNNotificationRequest(identifier: plant.notificationID,
                                            content: content,
                                            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }

    func cancelReminder(for plant: Plant) {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: [plant.notificationID])
    }
}
