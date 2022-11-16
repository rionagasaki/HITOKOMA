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
    @ObservedObject var model:MyBackendModel
    @EnvironmentObject var user: User
    let amount: Int
    let lessonId: String
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
                    ProgressView().onAppear{
                        UpdateFirestore().updatePaymentIntent(lessonId: lessonId) {
                            self.user.appendPurchaseLessons(lessonid: self.lessonId)
                        }
                    }
                case .canceled:
                    HStack{
                        Image(systemName: "exclamationmark.triangle.fill").foregroundColor(.yellow)
                        Text("Payment Canceled")
                    }
                case .failed:
                    Image(systemName: "exclamationmark.triangle.fill").foregroundColor(.red)
                    Text("Payment failed")
                }
            }
        }.onAppear{
            FetchFromFirestore().fetchUserInfoFromFirestore { result in
                model.preparePaymentSheet(customerId: result.customerId, amount: amount)
            }
        }
    }
}


struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(model: MyBackendModel(), amount: 0, lessonId: "")
    }
}
