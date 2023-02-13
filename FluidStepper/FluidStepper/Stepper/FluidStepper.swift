//
//  FluidStepper.swift
//  FluidStepper
//
//  Github: https://github.com/Kushalbhavsar
//  Created by Kush on 12/02/23.
//

import SwiftUI

struct FluidStepper: View {
    
    //Properties
    var width: CGFloat = 250
    var minValue: Int  = 0
    var maxValue: Int  = 100
    
    @Binding var value: Int
    @State private(set) var labelOffset: CGSize      = .zero
    @State private(set) var dragDirection: Direction = .none

    var body: some View {
        ZStack {
            ControlSegmentView()
                .animation(springAnimation, value: controlsContainerOffset)
            
            LabelView()
                .animation(springAnimation, value: labelOffset)
                .highPriorityGesture (
                    DragGesture()
                        .onChanged { value in
                            updateDragLocation(with: value.translation)
                            updateOffset(with: value)
                        }
                        .onEnded { _ in self.updateStepperValue() }
                    )
        }
    }
}


//MARK: - Views -
private extension FluidStepper {
    private func ControlSegmentView() -> some View {
        HStack(spacing: spacing) {
            ControlButton(
                systemName: "minus",
                size: controlFrameSize,
                isActive: dragDirection == .left,
                opacity: leftControlOpacity,
                action: decrease
            )
            
            ControlButton(
                systemName: "xmark",
                size: controlFrameSize,
                isActive: dragDirection == .down,
                opacity: controlsOpacity
            )
            .allowsHitTesting(false)
            
            ControlButton(
                systemName: "plus",
                size: controlFrameSize,
                isActive: dragDirection == .right,
                opacity: rightControlOpacity,
                action: increase
            )
        }
        .padding(.horizontal, spacing)
        .background(
            RoundedRectangle(cornerRadius: controlsContainerCornerRadius)
                .fill(Color.controlBackground)
                .overlay(
                    Color.black.opacity(controlsContainerOpacity)
                        .clipShape(RoundedRectangle(cornerRadius: controlsContainerCornerRadius))
                )
                .frame(width: width, height: controlsContainerHeigth)
        )
        .offset(controlsContainerOffset)
    }
    
    private func LabelView() -> some View {
        ZStack {
            Circle()
                .fill(Color.labelBackground)
                .frame(width: labelSize, height: labelSize)
            
            Text("\(value)")
                .foregroundColor(.white)
                .font(.system(size: labelFontSize, weight: .semibold, design: .rounded))
        }
        .drawingGroup()
        .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 5)
        .contentShape(Circle())
        .onTapGesture { self.value += 1 }
        .offset(self.labelOffset)
    }
}

//MARK: - Methods -
private extension FluidStepper {
    private func updateDragLocation(with translation: CGSize) {
        withAnimation {
            print(translation.height)
            if translation.height <= 0 {
                if translation.width > 10 {
                    self.dragDirection = .right
                } else if translation.width < 10 {
                    self.dragDirection = .left
                }
            } else if self.dragDirection == .none {
                self.dragDirection = .down
            }
        }
    }
    
    private func updateOffset(with value : DragGesture.Value) {
        var newWidth: CGFloat = 0
        
        if value.translation.width > 0 {
            newWidth = min(value.translation.width * 0.75,
                           width / 2 - (labelSize / 2) )
        } else if value.translation.width < 0 {
            newWidth = max((value.translation.width * 0.75), -((width / 2) - (labelSize / 2)))
        }
        
        let newHeight = min(value.translation.height * 0.75, (controlsContainerHeigth * 0.8))
        
        withAnimation {
            self.labelOffset = .init(
                width: self.dragDirection  == .down ? 0 : newWidth,
                height: self.dragDirection == .down ? newHeight : 0
            )
        }
    }
    
    private func updateStepperValue() {
        switch dragDirection {
        case .none:
            break
        case .left:
            self.decrease()
        case .right:
            self.increase()
        case .down:
            self.reset()
        }
        
        withAnimation {
            self.labelOffset = .zero
            self.dragDirection = .none
        }
    }
}

//MARK: - Operations
private extension FluidStepper {
    
    private func decrease() {
        if self.value != minValue { self.value -= 1 }
    }
    
    private func increase() {
        if self.value < maxValue { self.value += 1 }
    }
    
    private func reset() { self.value = 0 }
}


#if DEBUG
struct FluidStepper_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
