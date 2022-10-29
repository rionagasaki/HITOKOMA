//
//  LoginBackgroundView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/21.
//

import SwiftUI

struct MyCustomShape: View {
    
    var body: some View{
        Canvas { context, size in
            context.fill(path(in: CGRect(x: 0, y: 0, width: size.width, height: size.height)), with: .linearGradient(Gradient(colors: [.yellow, .orange.opacity(0.8)]), startPoint:CGPoint(x: 30, y: 30), endPoint: CGPoint(x: 300, y: 300)))
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.addEllipse(in: CGRect(x: 0, y: 0, width: width, height: height))
        return path
    }
}

struct LoginBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        MyCustomShape().frame(width: 200, height: 200)
    }
}
