//
//  ShamaliahRegion.swift
//  FenjalAlhaif
//
//  Created by jumanah khalid albisher on 01/04/1445 AH.
//

import SwiftUI

struct ShamaliahRegion: View {
    let gifName: String
    @State private var isVibrating = false
    @State var didTap = false
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
                        background2.playBackground2()
                        isPlaying = true
                    }
                
                Image ("pan")
                    .resizable()
                    .frame(width: 430, height: 430)
                    .offset(x:13,y:-5)
                    .rotationEffect(Angle(degrees: isVibrating ? 30 : 20))
                    .animation(isVibrating ? .linear(duration: 0.5).repeatForever(autoreverses: true) : .default)
                Image ("ShamaliBean")
                    .resizable()
                    .frame(width: 570, height: 500)
                    .offset(x:-20,y:-25.5)
                    .rotationEffect(Angle(degrees: isVibrating ? 40 : 0))
                    .animation(isVibrating ? .linear(duration: 0.5).repeatForever(autoreverses: true) : .default)
                
                Button("احمص") {
                    self.didTap = true
                    self.isVibrating.toggle()
                }
                .font(.system(size: 40))
                .frame(width: 430, height: 430)
                .buttonStyle(.bordered)
                .tint(.clear)
                .shadow(radius:50)
                .offset(x: 320, y: 50)
                
                if navigateToTahona {
                    Tahona().transition(.slide)
                }
                
                Button(action: {
                    navigateToTahona = true
                }) {
                    Text("انقلني إلى Tahona")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .offset(x: 0, y: 200)
            }
            
        }
        .ignoresSafeArea()
    }
}
