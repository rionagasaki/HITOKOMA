//
//  DashBoardCall.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/02.
//

import UIKit
import Foundation
import FirebaseFunctions
import PKHUD
import SafariServices
import SwiftUI

class DashBoardCallViewController: UIViewController{
    private lazy var functions = Functions.functions()
    private let urlString = "https://us-central1-marketsns.cloudfunctions.net/createDashboardLink"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callBackend()
    }
    
    func callBackend(){
        HUD.show(.progress)
        functions.httpsCallable(URL(string: urlString)!).call { result, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = result?.data as? [String: Any] else { return }
            let dashboardURLString = data["url"] as? String
            let dashboardURL = URL(string: dashboardURLString!)
            let safariViewController = SFSafariViewController(url:dashboardURL!)
            safariViewController.delegate = self
            
            DispatchQueue.main.async {
                HUD.hide()
                self.present(safariViewController, animated: true, completion: nil)
            }
        }
    }
}

extension DashBoardCallViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        // the user may have closed the SFSafariViewController instance before a redirect
        // occurred. Sync with your backend to confirm the correct state
    }
}

struct WrappaerDashBoardCall: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        DashBoardCallViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
