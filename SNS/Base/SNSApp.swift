//
//  SNSApp.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/09/04.
//

import SwiftUI
import FirebaseCore
import Stripe

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      StripeAPI.defaultPublishableKey = "pk_live_51LvcnMIMOIL9adjNh3OIuKk0MmuwweiIhZHigNYZzW2OhqPJ6WYRdHI3AwMHOmOYeO9OETa1l8kMDOhhVA3xnJaE0002hJn7m7"
    return true
  }
}

@main
struct SNSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
          RootView().environmentObject(AppState())
        }
    }
}
