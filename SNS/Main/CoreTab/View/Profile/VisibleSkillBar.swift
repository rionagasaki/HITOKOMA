//
//  VisibleSkillBar.swift
//  SNS
//
//  Created by Rio Nagasaki on 2023/01/08.
//

import SwiftUI

struct VisibleSkillBar: View {
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 200, height: 10)
                .foregroundColor(.customLightGray)
            RoundedRectangle(cornerRadius: 10)
                .frame(width:50, height: 10)
                .foregroundColor(.customBlue)
        }
    }
}

struct VisibleSkillBar_Previews: PreviewProvider {
    static var previews: some View {
        VisibleSkillBar()
    }
}
