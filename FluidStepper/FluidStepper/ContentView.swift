//
//  ContentView.swift
//  FluidStepper
//
//  Github: https://github.com/Kushalbhavsar
//  Created by Kush on 12/02/23.
//

import SwiftUI

struct ContentView: View {
    
    // - Properties -
    @State private(set) var value: Int = 0
    
    // - Body -
    var body: some View {
        ZStack {
            Color.screenBackground.edgesIgnoringSafeArea(.all)
            FluidStepper(value: $value)
        }
    }
}


#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
