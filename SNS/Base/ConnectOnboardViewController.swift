//
//  ConnectOnboardViewController.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/01.
//

import UIKit
import SafariServices
import FirebaseFunctions
import SwiftUI
import PKHUD

let BackendAPIBaseURL: String = "https://us-central1-marketsns.cloudfunctions.net/stripeCreateAccount"

class ConnectOnboardViewController: UIViewController {
    
    private lazy var functions = Functions.functions()
    
    private let connectWithStripeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Stripeと連携する", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
       
        button.layer.shadowColor = UIColor.startColor.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 10
    
        return button
    }()
    
    private let mainTitle: UILabel = {
       let label = UILabel()
        label.text = "Stripeと連携して、\n出品者になろう。"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.numberOfLines = 0
        return label
    }()
    
    private let mainImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "teachBigin"))
        imageView.sizeToFit()
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTitle.frame = CGRect(x: 30, y: 0, width: mainTitle.intrinsicContentSize.width, height: mainTitle.intrinsicContentSize.height)
        mainImage.frame = CGRect(x:(UIScreen.main.bounds.width/2)-150, y: mainTitle.frame.maxY + 30, width: 300, height: 300)
        connectWithStripeButton.frame = CGRect(x:(UIScreen.main.bounds.width/2)-125, y: UIScreen.main.bounds.height-270, width: 250, height: 50)
        connectWithStripeButton.layer.cornerRadius = connectWithStripeButton.bounds.midY
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = connectWithStripeButton.bounds
        gradientLayer.cornerRadius = connectWithStripeButton.bounds.midY
        gradientLayer.colors = [UIColor.startColor.cgColor, UIColor.endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        connectWithStripeButton.addTarget(self, action: #selector(didSelectConnectWithStripe), for: .touchUpInside)
        connectWithStripeButton.layer.insertSublayer(gradientLayer, at: 0)
        view.addSubview(mainTitle)
        view.addSubview(mainImage)
        view.addSubview(connectWithStripeButton)
    }
    
     @objc func didSelectConnectWithStripe() {
        HUD.show(.progress)
        functions.httpsCallable(URL(string: "https://us-central1-marketsns.cloudfunctions.net/createAccountLink")!)
            .call{result, error in
                if let error = error {
                    print("ERROR \(error)")
                    return
                }
                guard let data = result?.data as? [String: Any] else { return }
                let accountLinkString = data["accountLink"] as? String
                let accountURL = URL(string: accountLinkString!)
                let safariViewController = SFSafariViewController(url: accountURL!)
                safariViewController.delegate = self
                
                DispatchQueue.main.async {
                    HUD.hide()
                    self.present(safariViewController, animated: true, completion: nil)
                }
            }
    }
}

extension ConnectOnboardViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        // the user may have closed the SFSafariViewController instance before a redirect
        // occurred. Sync with your backend to confirm the correct state
    }
}

struct WrapperConnectOnboardViewController: UIViewControllerRepresentable{
    func makeUIViewController(context: Context) -> some UIViewController {
        ConnectOnboardViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}
