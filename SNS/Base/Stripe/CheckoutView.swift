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
                    Text("購入する").foregroundColor(.white).font(.system(size: 17)).bold().frame(width: UIScreen.main.bounds.width-40, height: 50).background(Color.customBlue).cornerRadius(10)
                }
            } else {
                ProgressView().frame(width: UIScreen.main.bounds.width-40, height: 50)
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
            model.preparePaymentSheet(customerId: user.customerId, amount: amount)
        }
    }
}


struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(model: MyBackendModel(), amount: 0, lessonId: "")
    }
}
