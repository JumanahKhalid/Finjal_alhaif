//
//  VibrationView.swift
//  FenjalAlhaif
//
//  Created by jumanah khalid albisher on 01/04/1445 AH.
//

//import SwiftUI
//import AVFoundation
//
//
//struct VibrationView: View {
//    @State private var isVibrating = false
//    @State private var vibrationDuration: Double = 0.0
//    //@State var didTap = false
//    @State private var goToIng: Bool = false
//    let player = try? AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "pour12", withExtension: "mp3")!)
//    
//    var body: some View {
//        
//        Button(action: {
//            if isVibrating {
//                stopVibrating()
//            } else {
//                startVibrating()
//                DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
//                    stopVibrating()
//                }
//            }
//        }) {
//            Image("طاحونة قهوة")
//                .resizable()
//                .frame(width: 400, height: 400)
//                .rotationEffect(Angle(degrees: isVibrating ? 0 : 0))
//                .animation(isVibrating ? .linear(duration: 0.1).repeatForever() : .default)
//                .offset(x: isVibrating ? 15 : 0, y: -20)
//        }
//        Button(action: {
//            goToIng = true
//        }) {
//            Image(systemName: "arrow.right.circle")
//                .font(.system(size: 40))
//                .tint(.red)
//                .shadow(radius: 50)
//        }
//        .fullScreenCover(isPresented: $goToIng, content: {
//            sIngredients()
//        })
//        
//        .edgesIgnoringSafeArea(.all)
//    }
//    
//    private func startVibrating() {
//        isVibrating = true
//        player?.play() // Play sound
//    }
//    
//    private func stopVibrating() {
//        isVibrating = false
//        player?.stop()
//    }
//}
