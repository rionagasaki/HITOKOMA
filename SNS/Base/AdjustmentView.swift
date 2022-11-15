//
//  AdjustmentView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/07.
//

import SwiftUI

struct AdjustmentView: View {
    var body: some View {
        ZStack{
            VStack{
                VStack(alignment:.leading ,spacing: 20){
                    Circle().size(width: 200, height: 200).blur(radius: 80).foregroundColor(.yellow)
                    HStack{
                        Circle().size(width: 200, height: 200).blur(radius: 40).foregroundColor(.blue).padding(.top,-120)
                        Circle().size(width: 200, height: 200).blur(radius: 40).foregroundColor(.orange).padding(.top,30)
                    }
                    Circle().size(width: 200, height: 200).blur(radius: 100).foregroundColor(.pink)
                }
            }
            
        }
    }
}

struct AdjustmentView_Previews: PreviewProvider {
    static var previews: some View {
        AdjustmentView()
    }
}
