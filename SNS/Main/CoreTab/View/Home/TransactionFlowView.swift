//
//  TransactionFlowView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2023/01/09.
//

import SwiftUI

struct TransactionFlowView: View {
    let currentPoint: Int
    let allFlowsText = ["事前","取引中","評価中","取引終了"]
    var body: some View {
        HStack(spacing: .zero){
            ForEach(allFlowsText.indices, id:\.self) { index in
                OneTransactionFlowView(point: index, flowText: allFlowsText[index])
            }
        }
    }
}

struct TransactionFlowView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionFlowView(currentPoint: 4)
    }
}

struct OneTransactionFlowView: View {
    let point: Int
    let flowText: String
    var body: some View {
        HStack(spacing: .zero){
            VStack(spacing: .zero){
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width:30, height:30)
                    .foregroundColor(.orange)
                    .padding(.bottom, 8)
                Text(flowText)
                    .fontWeight(.light)
                    .font(.system(size:12))
                    .frame(height:10)
                    .foregroundColor(.black)
            }
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 40, height:3)
                .foregroundColor(.orange)
                .padding(.leading, -2)
                .padding(.bottom, 16)
        }
    }
}

public enum Flow: Int {
    case first = 0
    case last = 3
}
