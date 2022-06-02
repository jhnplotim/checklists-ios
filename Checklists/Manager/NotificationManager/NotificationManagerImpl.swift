// 
//  NotificationManagerImpl.swift
//  Checklists
//
//  Created by John Paul Otim on 02.06.22.
//

import UIKit
import UserNotifications

// MARK: - Manager Implementation

final class NotificationManagerImpl: NSObject, NotificationManager {

    // MARK: - Typealias

    typealias DI = DependencyContainer

    // MARK: - Constant

    private let di: DI
    
    private let notificationCenter: UNUserNotificationCenter

    // MARK: - Initializer

    init(di: DependencyContainer) {
        self.di = di
        self.notificationCenter = UNUserNotificationCenter.current()
        super.init()
        self.notificationCenter.delegate = self
    }

}

// MARK: - Public

extension NotificationManagerImpl {

    func requestAuthorization(options: UNAuthorizationOptions, completionHandler: @escaping (Bool, Error?) -> Void) {
        notificationCenter.requestAuthorization(options: options, completionHandler: completionHandler)
    }
    
    func requestAuthorization(completionHandler: @escaping (Bool, Error?) -> Void) {
        notificationCenter.requestAuthorization(completionHandler: completionHandler)
    }
    
    func scheduleLocalNotification(notification: NotificationModel) {
        // TODO: Consider requesting authorisation first
        notificationCenter.add(notification.notificationRequest)
    }
    
    func scheduleLocalNotification(notification: NotificationModel, withCompletionHandler completionHandler: ((Error?) -> Void)? = nil) {
        notificationCenter.add(notification.notificationRequest, withCompletionHandler: completionHandler)
    }
    
    func removeAllPendingNotificationRequests() {
        notificationCenter.removeAllPendingNotificationRequests()
    }
    
    func removePendingNotificationRequests(withIdentifiers identifiers: [String]) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: identifiers)
    }
}

// MARK: UNUserNotificationCenterDelegate

extension NotificationManagerImpl {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Received local notification \(notification)")
    }
}

// MARK: - Private

extension NotificationManagerImpl {

}
