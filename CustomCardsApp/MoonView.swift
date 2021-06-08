//
//  MoonView.swift
//  CustomCardsApp
//
//  Created by Mihajlo Mit on 2021-06-02.
//

import SwiftUI
import UIKit

struct LunarPhaseView: UIViewRepresentable {
    typealias UIViewType = LunarPhaseViewImpl
    
    func makeUIView(context: UIViewRepresentableContext<LunarPhaseView>) -> LunarPhaseViewImpl {
        let view = LunarPhaseViewImpl(
            frame: CGRect.zero,
            date: Date()
        )
        return view
    }
    
    func updateUIView(_ uiView: LunarPhaseViewImpl,
                      context: UIViewRepresentableContext<LunarPhaseView>) {
        uiView.backgroundColor = UIColor.clear
    }
}



