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

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      FirebaseApp.configure()
        StripeAPI.defaultPublishableKey = "pk_test_51LvcnMIMOIL9adjNYRI6Tr2V1KOmdpf1l2xpG5dlSyo6Ek146iRPhwgVmNDwYmDhmtAV785Lc5qe2s9gTkxMO7Oc00UVvNaqQF"
      UNUserNotificationCenter.current().delegate = self
      Messaging.messaging().delegate = self
      let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
      UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { authorized, error in
              if let error = error {
                  print("Error=>UNUserNotificationCenter:\(error)")
              } else {
                  DispatchQueue.main.async {
                      application.registerForRemoteNotifications()
                  }
              }
          }
    return true
  }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
            }else if let token = token {
                print("FCM registration token: \(token)")
              }
        }
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
           // Called when a new scene session is being created.
           // Use this method to select a configuration to create the new scene with.
           return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
       }

       func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
           // Called when the user discards a scene session.
           // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
           // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
       }

       func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
           // Print message ID.
           if let messageID = userInfo["gcm.message_id"] {
               print("Message ID: \(messageID)")
           }

           // Print full message.
           print(userInfo)
       }

       func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
           // Print message ID.
           if let messageID = userInfo["gcm.message_id"] {
               print("Message ID: \(messageID)")
           }

           // Print full message.
           print(userInfo)

           completionHandler(UIBackgroundFetchResult.newData)
       }
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                   willPresent notification: UNNotification,
                                   withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
           let userInfo = notification.request.content.userInfo

           if let messageID = userInfo["gcm.message_id"] {
               print("Message ID: \(messageID)")
           }

           print(userInfo)

           completionHandler([])
       }

       func userNotificationCenter(_ center: UNUserNotificationCenter,
                                   didReceive response: UNNotificationResponse,
                                   withCompletionHandler completionHandler: @escaping () -> Void) {
           let userInfo = response.notification.request.content.userInfo
           if let messageID = userInfo["gcm.message_id"] {
               print("Message ID: \(messageID)")
           }

           print(userInfo)

           completionHandler()
       }
}

@main
struct SNSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            RootView().environmentObject(AppState()).environmentObject(User())
        }
    }
}
