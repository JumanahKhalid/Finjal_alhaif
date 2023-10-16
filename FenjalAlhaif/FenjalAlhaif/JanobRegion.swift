//
//  JanobRegion.swift
//  FenjalAlhaif
//
//  Created by jumanah khalid albisher on 01/04/1445 AH.
//

import SwiftUI
import AVFoundation

struct JanobRegion: View {
    let gifName: String
    @State private var isVibrating = false
    @State private var tapCount = 0 // Track the number of taps
    @State private var isPlaying = false
    @State private var navigateToTahona = false
    @StateObject private var background2 = Background2.shared
    @State private var isNextPageActive = false
    @State private var isPresented = false
    
    let player = try? AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "صوت-الحمص", withExtension: "mp3")!)
    
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
                
                Image ("Janobbean")
                    .resizable()
                    .frame(width: 480, height: 480)
                    .offset(x:-10,y:-55)
                    .rotationEffect(Angle(degrees: isVibrating ? 40 : 0))
                    .animation(isVibrating ? .linear(duration: 0.5).repeatForever(autoreverses: true) : .default)
                
                Button("احمص") {
                    tapCount += 1 // Increment the tap count
                    isVibrating.toggle()
                    player?.play()
                    
                  
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
                      //isPresented = true
                    navigateToTahona = true // Transition to Tahona view
                    }) {
                        Image(systemName: "arrow.right.circle")
                            .font(.system(size: 40))
                            .tint(.red)
                            .shadow(radius:50)
                            
                    }
                    .offset(x: 350, y: -10)
                    //.fullScreenCover(isPresented: $isPresented, content: Tahona.init )
                      
                }
            }
        }
        .ignoresSafeArea()
    }
}
