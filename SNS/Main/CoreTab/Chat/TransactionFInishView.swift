//
//  TransactionFInishView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/30.
//

import SwiftUI

struct TransactionFInishView: View {
    var body: some View {
        VStack{
            AfterLessonView(allSelection: -1, clearitySelection: -1)
        }
    }
}

struct TransactionFInishView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionFInishView()
    }
}
