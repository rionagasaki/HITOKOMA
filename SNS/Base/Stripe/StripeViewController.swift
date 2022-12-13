//
//  StripeViewController.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/27.
//

import UIKit
import StripePaymentsUI
import StripePaymentSheet
import SwiftUI
import FirebaseFunctions

class CheckoutViewController: UIViewController {
    
    var paymentSheet: PaymentSheet?
    
    
    lazy var cardView: STPCardFormView = {
        let cardView = STPCardFormView()
        return cardView
    }()
    lazy var cardTextField: STPPaymentCardTextField = {
        let cardTextField = STPPaymentCardTextField()
        cardTextField.cvcPlaceholder = "セキュリティコード"
        return cardTextField
    }()
    lazy var payButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        button.setTitle("Pay", for: .normal)
        button.addTarget(self, action: #selector(pay), for: .touchUpInside)
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let stackView = UIStackView(arrangedSubviews: [cardView, cardTextField, payButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalToSystemSpacingAfter: view.leftAnchor, multiplier: 2),
            view.rightAnchor.constraint(equalToSystemSpacingAfter: stackView.rightAnchor, multiplier: 2),
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 2),
        ])
    }
    
    @objc
    func pay() {
        // ...
    }
}

struct CheckoutViewControllerWrapper: UIViewControllerRepresentable{
    func makeUIViewController(context: Context) -> some UIViewController {
        return CheckoutViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

class MyBackendModel: ObservableObject {
    @EnvironmentObject var user: User
    // MARK: EndPoint
    //    let customHandlers = PaymentSheet.ApplePayConfiguration.Handlers(
    //        authorizationResultHandler: { result, completion in
    //            // Fetch the order details from your service
    //            MyAPIClient.shared.fetchOrderDetails(orderID:) { myOrderDetails
    //                result.orderDetails = PKPaymentOrderDetails(
    //                    orderTypeIdentifier: myOrderDetails.orderTypeIdentifier, // "com.myapp.order"
    //                    orderIdentifier: myOrderDetails.orderIdentifier, // "ABC123-AAAA-1111"
    //                    webServiceURL: myOrderDetails.webServiceURL, // "https://my-backend.example.com/apple-order-tracking-backend"
    //                    authenticationToken: myOrderDetails.authenticationToken) // "abc123"
    //                // Call the completion block on the main queue with your modified PKPaymentAuthorizationResult
    //                completion(result)
    //            }
    //        }
    //    )
    let backendCheckoutUrl = URL(string: "https://asia-northeast1-marketsns.cloudfunctions.net/createPaymentIntents")!

    lazy var functions = Functions.functions()
    
    @Published var paymentSheet: PaymentSheet?
    @Published var paymentResult: PaymentSheetResult?
    
    func preparePaymentSheet(customerId: String, amount: Int) {
        // MARK: Fetch the PaymentIntent and Customer information from the backend
        functions.httpsCallable(URL(string: "https://asia-northeast1-marketsns.cloudfunctions.net/createPaymentIntents")!).call(["customerId": customerId, "amount": amount]){ result, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = result?.data as? [String: Any] ,
                  let customerId = data["customer"] as? String,
                  let customerEphemeralKeySecret = data["ephemeralKey"] as? String,
                  let paymentIntent = data["paymentIntent"] as? String,
                  let publishableKey = data["publishableKey"] as? String else {
                return
            }
            STPAPIClient.shared.publishableKey = publishableKey
            var configuration = PaymentSheet.Configuration()
            var appearance = PaymentSheet.Appearance()
            appearance.cornerRadius = 12
            configuration.applePay = .init(merchantId: "merchant.com.HITOKOMA",
                                           merchantCountryCode: "JP")
            configuration.appearance = appearance
            configuration.merchantDisplayName = "Example, Inc."
            configuration.customer = .init(id:customerId, ephemeralKeySecret: customerEphemeralKeySecret)
            configuration.allowsDelayedPaymentMethods = true
            
            DispatchQueue.main.async {
                self.paymentSheet = PaymentSheet(paymentIntentClientSecret: paymentIntent, configuration: configuration)
                print("payment!!", self.paymentSheet)
            }
        }
    }
    
    func onPaymentCompletion(result: PaymentSheetResult) {
        self.paymentResult = result
    }
}

