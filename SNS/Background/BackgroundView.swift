//
//  BackgroundView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/10/14.
//

import SwiftUI

struct BackgroundView: View {
    @State var startColor:Color
    @State var endColor:Color
    var body: some View{
        TimelineView(.animation) { timeline in
            let now = timeline.date.timeIntervalSinceReferenceDate
            let angle = Angle.degrees(now.remainder(dividingBy: 3) * 120)
            let x = cos(angle.radians)
            Canvas { context, size in
                context.fill(path(in: CGRect(x: 0, y: 0, width: size.width, height: size.height), x: x), with: .linearGradient(Gradient(colors: [startColor, endColor]), startPoint:CGPoint(x: 100, y: 100), endPoint: CGPoint(x: 300, y: 300)))
            }
        }.frame(width: 350, height: 300)
    }
    func path(in rect: CGRect, x:Double) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: width, y: 0.67949*height*x))
        path.addCurve(to: CGPoint(x: 0.56967*width, y: height), control1: CGPoint(x: width*x, y: 0.93439*height), control2: CGPoint(x: 0.89787*width, y: height))
        path.addCurve(to: CGPoint(x: 0.00205*width*x, y: 0.31282*height), control1: CGPoint(x: 0.24147*width*x, y: height), control2: CGPoint(x: 0.00205*width*x, y: 0.56772*height*x))
        
        path.addCurve(to: CGPoint(x: 0.66598*width*x, y:x), control1: CGPoint(x: 0.00205*width*x, y: 0.05792*height), control2: CGPoint(x: 0.03778*width*x, y: 0))
        path.addCurve(to: CGPoint(x: width, y: 0.67949*height), control1: CGPoint(x: width, y: 0), control2: CGPoint(x: width, y: 0.42459*height))
        path.closeSubpath()
        return path
    }
}
struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView(startColor: .purple, endColor: .blue)
    }
}
