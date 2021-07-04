//
//  ImageModifications.swift
//  Iconology
//
//  Created by Liam Rosenfeld on 6/8/21.
//  Copyright © 2021 Liam Rosenfeld. All rights reserved.
//

import AppKit
import Combine

class ImageModifications: ObservableObject {
    @Published var aspect: CGSize
    @Published var scale: CGFloat
    @Published var shift: CGPoint
    @Published var background: Background
    @Published var rounding: CGFloat
    @Published var padding: CGFloat
    @Published var shadow: ShadowAttributes

    init() {
        aspect = CGSize(width: 1, height: 1)
        scale = 100
        shift = .zero
        background = .none
        rounding = 0
        padding = 0
        shadow = (0, 0)
    }
}

typealias ShadowAttributes = (opacity: CGFloat, blur: CGFloat)