//
//  LottieView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/11/01.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable{
    var name: String
    

    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
        let animationView = LottieAnimationView(name: name)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
                    animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
                    animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
                ])
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
