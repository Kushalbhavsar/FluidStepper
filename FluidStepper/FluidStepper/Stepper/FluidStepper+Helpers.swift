//
//  FluidStepper+helpers.swift
//  FluidStepper
//
//  Github: https://github.com/Kushalbhavsar
//  Created by Kush on 13/02/23.
//

import SwiftUI

// MARK: Enum `Direction`
extension FluidStepper {
    enum Direction { case none, left, right, down }
}

extension FluidStepper {
    var springAnimation: Animation { .interpolatingSpring(stiffness: 350, damping: 15) }
}

extension FluidStepper {
    var defaultControlsOpacity: Double { 0.4 }
    var spacing: CGFloat { width / 10 }
    
    var controlsContainerHeigth: CGFloat { width / 2.5 }
    var controlsContainerCornerRadius: CGFloat { width / 4.9 }
    var controlsContainerOffset: CGSize {
        .init(
            width:  labelOffset.width / 6,
            height: labelOffset.height / 6
        )
    }
    var controlsContainerOpacity: Double { controlsOpacity * 0.2 + abs(labelOffsetXInPercents) * 0.25 }
    var controlsOpacity: Double { labelOffsetYInPercents }
    
    var controlFrameSize: CGFloat { width / 4.2 }
    
    var leftControlOpacity: Double {
        if labelOffset.width < 0 {
            return -Double(labelOffset.width / (labelOffsetXLimit * 0.65)) + defaultControlsOpacity
        } else {
            return defaultControlsOpacity - controlsOpacity - labelOffsetXInPercents / 3.5
        }
    }
    var rightControlOpacity: Double {
        if labelOffset.width > 0 {
            return Double(labelOffset.width / (labelOffsetXLimit * 0.65)) + defaultControlsOpacity
        } else {
            return defaultControlsOpacity - controlsOpacity + labelOffsetXInPercents / 3.5
        }
    }
    
    var labelSize: CGFloat { width / 3 }
    var labelFontSize: CGFloat { labelSize / 2.5 }
    var labelOffsetXLimit: CGFloat { width / 3 + spacing}
    var labelOffsetYLimit: CGFloat { controlsContainerHeigth / 1.2 }
    var labelOffsetXInPercents: Double { Double(labelOffset.width / labelOffsetXLimit) }
    var labelOffsetYInPercents: Double { Double(labelOffset.height / labelOffsetYLimit) }
}

