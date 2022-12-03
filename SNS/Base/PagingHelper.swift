//
//  PagingHelper.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/12/01.
//

import SwiftUI

struct PagingHelper<Contents: View, Labels: View>:View {
    var contents: Contents
    var labels: Labels
    
    init(@ViewBuilder contents: @escaping () -> Contents, @ViewBuilder labels: @escaping () -> Labels){
        self.contents = contents()
        self.labels = labels()
    }
    
    @State var offset: CGFloat = 0
    
    @MainActor public var body: some View {
        VStack(spacing: 0){
            HStack{
                labels
            }
            OffsetPageTabView(offset: $offset) {
                contents
            }
        }
    }
}
