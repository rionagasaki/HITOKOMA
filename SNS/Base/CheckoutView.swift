//
//  CheckoutView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/28.
//

import SwiftUI
import StripePaymentSheet
import Lottie

struct CheckoutView: View {
    @ObservedObject var model = MyBackendModel()
    
    var body: some View {
        VStack(alignment: .center){
            if let paymentSheet = model.paymentSheet {
                PaymentSheet.PaymentButton(paymentSheet: paymentSheet, onCompletion:model.onPaymentCompletion) {
                    RichButton(buttonText: "注文する", buttonImage: "pc").shadow(color: .blue.opacity(0.1), radius: 10, x: 10, y: 10).shadow(color: .white, radius: 20, x: -5, y: -5)
                }
            } else {
                ProgressView()
            }
            if let result = model.paymentResult {
                switch result {
                case .completed:
                    HStack{
                        Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
                        Text("購入済み")
                    }
                case .canceled:
                    HStack{
                        Image(systemName: "exclamationmark.triangle.fill").foregroundColor(.yellow)
                        Text("Payment Canceled")
                    }
                case .failed(let error):
                    Text("Payment failed: \(error.localizedDescription)")
                }
            }
        }.onAppear{
            FetchFromFirestore().fetchUserInfoFromFirestore { result in
                model.preparePaymentSheet(customerId: result.customerId)
            }
            
        }
    }
}


struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
    }
}
