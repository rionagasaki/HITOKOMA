//
//  PurchaseView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/22.
//

import SwiftUI

struct PurchaseView: View {
    var body: some View {
        VStack{
            RichButton(buttonText: "ひとこま購入", buttonImage: "checkmark.diamond.fill")
        }
    }
}

struct PurchaseView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseView()
    }
}
