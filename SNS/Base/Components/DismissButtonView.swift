//
//  DismissButtonView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/11.
//

import SwiftUI

struct DismissButtonView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "arrow.left").resizable().frame(width:20, height: 20).padding().background(Color.customGray).foregroundColor(.white).clipShape(Circle())
        }
    }
}

struct DismissButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DismissButtonView()
    }
}
