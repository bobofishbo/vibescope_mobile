//
//  vibescope_mobile_v1App.swift
//  vibescope_mobile_v1
//
//  Created by XIE BO on 2025/2/4.
//

import SwiftUI

import UIKit
import UserNotifications

// Step 1: Declare UNUserNotificationCenterDelegate
class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        
        registerForNotifications()
        return true
    }

    // Step 2: Register for push notifications
    func registerForNotifications() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self // 🔥 Important to handle foreground notifications

        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("❌ Error requesting notification authorization: \(error.localizedDescription)")
            } else {
                print("✅ Permission granted: \(granted)")
                
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }

    // Step 3: Handle foreground notifications (so they appear even when app is open)
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.badge, .sound, .alert]) // 🔥 Show alert even in foreground
    }

    // Step 4: Handle successful device token registration
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("📲 Device Token: \(token)")
    }

    // Step 5: Handle failure to register for push notifications
    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
        print("❌ Failed to register for notifications: \(error.localizedDescription)")
    }
}


@main
struct vibescope_mobile_v1App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
