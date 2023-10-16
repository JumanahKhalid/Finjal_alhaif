//
//  NajdRegion.swift
//  FenjalAlhaif
//
//  Created by jumanah khalid albisher on 01/04/1445 AH.
//

import SwiftUI

struct NajdRegion: View {
    let gifName: String
    @State private var isVibrating = false
    @State private var tapCount = 0 // Track the number of taps
    @State private var isPlaying = false
    @State private var navigateToTahona = false
    @StateObject private var background2 = Background2.shared
    @State private var isNextPageActive = false
    
    var body: some View {
        VStack {
            ZStack {
                Text(gifName)
                
                GifImage(gifName)
                    .frame(width: 988, height: 450)
                    .offset(x: 40, y: -10)
                    .onAppear {
                        if !isNextPageActive {
                            background2.playBackground2()
                            isPlaying = true
                        }
                    }
                    .onDisappear {
                        if isPlaying {
                            background2.stopBackground2()
                            isPlaying = false
                        }
                    }
                
                Image("pan")
                    .resizable()
                    .frame(width: 430, height: 430)
                    .offset(x: 13, y: -5)
                    .rotationEffect(Angle(degrees: isVibrating ? 30 : 20))
                    .animation(isVibrating ? .linear(duration: 0.5).repeatForever(autoreverses: true) : .default)
                
                Image("NajdBean")
                    .resizable()
                    .frame(width: 480, height: 480)
                    .offset(x: -20, y: -25.5)
                    .rotationEffect(Angle(degrees: isVibrating ? 40 : 0))
                    .animation(isVibrating ? .linear(duration: 0.5).repeatForever(autoreverses: true) : .default)
                
                Button("احمص") {
                    tapCount += 1 // Increment the tap count
                    isVibrating.toggle()
                    
                  
                }
                .font(.system(size: 40))
                .frame(width: 430, height: 430)
                .buttonStyle(.bordered)
                .tint(.clear)
                .shadow(radius: 50)
                .offset(x: 320, y: 50)
                
                if navigateToTahona {
                    Tahona().transition(.slide)
                }
                
                if tapCount >= 3 { // Show the arrow button after 3 taps
                    Button(action: {
                        navigateToTahona = true // Transition to Tahona view
                    }) {
                        Image(systemName: "arrow.right.circle")
                            .font(.system(size: 40))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .offset(x: 0, y: 200)
                }
            }
        }
        .ignoresSafeArea()
    }
}

