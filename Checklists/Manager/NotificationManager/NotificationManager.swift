// 
//  NotificationManager.swift
//  Checklists
//
//  Created by John Paul Otim on 02.06.22.
//

import Foundation
import UserNotifications

// MARK: - Manager Type Definition

protocol NotificationManager: UNUserNotificationCenterDelegate {
    func requestAuthorization(options: UNAuthorizationOptions, completionHandler: @escaping (Bool, Error?) -> Void)
    
    func requestAuthorization(completionHandler: @escaping (Bool, Error?) -> Void)
    
    func scheduleLocalNotification(notification: NotificationModel)
    
    func scheduleLocalNotification(notification: NotificationModel, withCompletionHandler completionHandler: ((Error?) -> Void)?)
    
    func removeAllPendingNotificationRequests()
    
    func removePendingNotificationRequests(withIdentifiers identifiers: [String])

}

// MARK: Manager Implementation

protocol WithNotificationManager: AnyObject {

    var notificationManager: NotificationManager { get }

}

struct NotificationModel {
    let identifier: String
    let title: String
    let body: String
    let sound: UNNotificationSound
    let trigger: UNNotificationTrigger?
}

extension NotificationModel {
    var notificationRequest: UNNotificationRequest {
        let content = UNMutableNotificationContent()
        content.title = self.title
        content.sound = self.sound
        content.body = self.body
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        return request
    }
}
