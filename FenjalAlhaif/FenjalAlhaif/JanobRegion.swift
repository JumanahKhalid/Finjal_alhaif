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
                    JanobTahona().transition(.slide)
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
import SwiftUI
import AVFoundation


struct jVibrationView: View {
    @State private var isVibrating = false
    @State private var vibrationDuration: Double = 0.0
    //@State var didTap = false
    @State private var goToIng: Bool = false
    let player = try? AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "pour12", withExtension: "mp3")!)
    
    var body: some View {
        
        Button(action: {
            if isVibrating {
                stopVibrating()
            } else {
                startVibrating()
                DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                    stopVibrating()
                }
            }
        }) {
            Image("طاحونة قهوة")
                .resizable()
                .frame(width: 400, height: 400)
                .rotationEffect(Angle(degrees: isVibrating ? 0 : 0))
                .animation(isVibrating ? .linear(duration: 0.1).repeatForever() : .default)
                .offset(x: isVibrating ? 15 : 0, y: -20)
        }
        Button(action: {
            goToIng = true
        }) {
            Image(systemName: "arrow.right.circle")
                .font(.system(size: 40))
                .tint(.red)
                .shadow(radius: 50)
        }
        .fullScreenCover(isPresented: $goToIng, content: {
            jIngredients()
        })
        
        .edgesIgnoringSafeArea(.all)
    }
    
    private func startVibrating() {
        isVibrating = true
        player?.play() // Play sound
    }
    
    private func stopVibrating() {
        isVibrating = false
        player?.stop()
    }
}


struct jIngredients: View {
   
    
    struct Ingredient: Identifiable {
        let id = UUID()
        let name: String
        var position = CGPoint(x: 100, y: 100)
        var dragOffset = CGSize.zero
        var isPlaced = false
        
        
    }
    
    @State private var ingredients: [Ingredient] = [
        Ingredient(name: "زعفران"),
        Ingredient(name: "هيل"),
        Ingredient(name: "شمر"),
        Ingredient(name: "زنجبيل"),
        Ingredient(name: "قرنفل"),
        Ingredient(name: "قرفة"),
        Ingredient(name: "قهوة مطحونة")
    ]
    
    @State private var goToPour = false
    var body: some View {
        ZStack {
            
            GifBackground(gifName: "#5 غلي المكونات")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
           
        
            
            HStack {
                ForEach(ingredients) { ingredient in
                    if !ingredient.isPlaced {
                        Image(ingredient.name)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300, height: 300)
                            .position(ingredient.position)
                            .offset(x:10,y:-55)
.gesture(
 DragGesture()
.onChanged { gesture in
let index = ingredients.firstIndex { $0.id == ingredient.id }
    ingredients[index!].dragOffset = gesture.translation
                                    }
    .onEnded { gesture in
let index = ingredients.firstIndex { $0.id == ingredient.id }
ingredients[index!].position.x += gesture.translation.width
ingredients[index!].position.y += gesture.translation.height
ingredients[index!].dragOffset = CGSize.zero
                                        
let threshold: CGFloat = 100
if abs(ingredients[index!].position.x - 500) < threshold && abs(ingredients[index!].position.y - 300) < threshold {
// Placed correctly
ingredients[index!].isPlaced = true
                                        } else {
// Not placed correctly, reset position
ingredients[index!].position = CGPoint(x: 100, y: 100)
                                        }
                                    }
                            )
                    }
                }
            }
            
            Button(action: {
                goToPour = true
            }) {
                Image(systemName: "arrow.right.circle")
                    .font(.system(size: 40))
                    .tint(.red)
                    .shadow(radius: 50)
            }
            .fullScreenCover(isPresented: $goToPour, content: PourView.init )
            
            
        }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}
