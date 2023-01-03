//
//  ErrorView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2023/01/03.
//

import SwiftUI

struct ErrorView: View {
    var body: some View {
        VStack {
            Image(systemName: "wifi.exclamationmark")
                .resizable()
                .frame(width: 90, height: 70)
                .foregroundColor(.customGray)
            Text("情報の取得ができませんでした。\nお手数ですが、ネットワークへの接続等に問題がないかを確認し、再度お試しください。")
                .fontWeight(.light)
                .font(.system(size: 13))
                .padding(.horizontal, 16)
                .multilineTextAlignment(.center)
                .padding(.top, 8)
                
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
    }
}
