//
//  Indicatorview.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/10.
//

import SwiftUI

struct Indicatorview: View {
    let selection: Int
    var body: some View {
        HStack(spacing: 10){
            ForEach(0..<5) { dot in
                Circle().frame(width:8).foregroundColor(dot == selection ? .black: .init(uiColor: .lightGray))
            }
        }
    }
}

struct Indicatorview_Previews: PreviewProvider {
    static var previews: some View {
        Indicatorview(selection: 3)
    }
}
