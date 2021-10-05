//
//  BlurView.swift
//  ActivitiesSound
//
//  Created by Khanh Thieu on 10/5/21.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterialDark))
        return view
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

