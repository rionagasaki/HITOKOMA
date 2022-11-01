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
      StripeAPI.defaultPublishableKey = "pk_test_51LvcnMIMOIL9adjNYRI6Tr2V1KOmdpf1l2xpG5dlSyo6Ek146iRPhwgVmNDwYmDhmtAV785Lc5qe2s9gTkxMO7Oc00UVvNaqQF"
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
