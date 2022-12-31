//
//  SNSApp.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/09/04.
//

import SwiftUI
import FirebaseCore
import Stripe
import FirebaseMessaging
import UserNotifications

@main
struct SNSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(AppState())
                .environmentObject(User())
        }
    }
}
