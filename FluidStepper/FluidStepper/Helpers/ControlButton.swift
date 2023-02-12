//
//  ControlButotn.swift
//  FluidStepper
//
//  Created by Kush on 12/02/23.
//

import SwiftUI

struct ControlButton: View {
    var systemName: String
    var size: CGFloat
    var isActive: Bool
    var opacity: Double
    var action: () -> Void = {}
    
    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(size / 3.5)
                .frame(width: size, height: size)
                .foregroundColor(Color.white.opacity(opacity))
                .background(Color.white.opacity(0.0000001))
                .clipShape(Circle())
        }
        .buttonStyle(ControlButtonStyle(systemName: systemName, size: size))
        .contentShape(Circle())
    }
}


// MARK: - Control ButtonStyle -
struct ControlButtonStyle: ButtonStyle {
    var systemName: String
    var size: CGFloat
    var padding: CGFloat
    
    init(systemName: String, size: CGFloat) {
        self.systemName = systemName
        self.size = size
        self.padding = size / 3.5
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .overlay(
                ZStack {
                    Image(systemName: systemName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(padding)
                        .foregroundColor(.controlBackground)
                }
                .frame(width: size, height: size)
                .opacity(configuration.isPressed ? 1 : 0)
                .animation(.linear(duration: 0.1), value: configuration.isPressed)
            )
            .font(.system(size: 60, weight: .thin, design: .rounded))
            .scaleEffect(configuration.isPressed ? 0.85 : 1)
        }
}
