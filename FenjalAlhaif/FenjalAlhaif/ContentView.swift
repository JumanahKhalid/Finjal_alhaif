//
//  ContentView.swift
//  FenjalAlhaif
//
//  Created by Ghadah Albassam on 16/10/2023.
//

import SwiftUI
import AVFoundation
import UIKit

class AudioPlayerManager: ObservableObject {
    static let shared = AudioPlayerManager()
    private var audioPlayer: AVAudioPlayer?
    
    func playBackgroundMusic() {
        guard let audioPath = Bundle.main.path(forResource: "home.sound", ofType: "mp3") else {
            print("Failed to find the audio file")
            return
        }
        
        let audioUrl = URL(fileURLWithPath: audioPath)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioUrl)
            audioPlayer?.numberOfLoops = -1 // لتكرار الصوت بشكل مستمر
            audioPlayer?.play()
        } catch {
            print("Failed to play the audio: \(error)")
        }
    }
    
    func stopBackgroundMusic() {
        audioPlayer?.stop()
    }
}

class Background2: ObservableObject {
    static let shared = Background2()
    private var audioPlayer: AVAudioPlayer?
    
    func playBackground2() {
        guard let audioPath = Bundle.main.path(forResource: "background2", ofType: "mp3") else {
            print("Failed to find the audio file")
            return
        }
        
        let audioUrl = URL(fileURLWithPath: audioPath)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioUrl)
            audioPlayer?.numberOfLoops = -1 // لتكرار الصوت بشكل مستمر
            audioPlayer?.play()
        } catch {
            print("Failed to play the audio: \(error)")
        }
    }
    
    func stopBackground2() {
        audioPlayer?.stop()
    }
}


struct GifBackground: UIViewRepresentable {
    var gifName: String
    
    func makeUIView(context: Context) -> UIView {
        let gifView = GifView()
        gifView.gifName = gifName
        return gifView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}

struct ContentView: View {
    @State var didTap = false
    @StateObject private var audioPlayerManager = AudioPlayerManager.shared
    @State private var isPlaying = false
    @State private var isNextPageActive = false
    
    var body: some View {
        
        NavigationStack{
            
            HStack {
                ZStack{
                    
                    
                    GifBackground(gifName: "#1 Home page")
                    
                    
                    Button("ارحبووو") { self.didTap = true}
                        .frame(maxWidth: .infinity)
                        .buttonStyle(.bordered)
                        .tint(.clear)
                        .shadow(radius:50)
                        .offset(CGSize(width: -30, height: 30))
                    
                    NavigationLink("", destination:  RegionsView(), isActive: $didTap)
                    EmptyView()
                       .onAppear {
                            if !isNextPageActive {
                                audioPlayerManager.playBackgroundMusic()
                                isPlaying = true
                            }
                        }
                        .onDisappear {
                            if isPlaying {
                                audioPlayerManager.stopBackgroundMusic()
                                isPlaying = false
                            }
                        }
                }
                
            } .edgesIgnoringSafeArea(.all)
          
        }
        .onAppear {
            audioPlayerManager.playBackgroundMusic()
            isPlaying = true
        }
        
    }
}



    




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


struct JanobRegion: View {
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

struct VibrationView: View {
    @State private var isVibrating = false
    @State private var vibrationDuration: Double = 0.0
    @State var didTap = false
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewInterfaceOrientation(.landscapeLeft)
        
    }
}
struct Tahona: View {
    
   // @State private var isP: Bool = false
    @State private var goToIng: Bool = false
    var body: some View {
        ZStack{
            
            ZStack{
                GifBackground(gifName: "خلفية الطاحونة")
                VibrationView()
            }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
           
            Button("Next") {
                goToIng = true
            }
            .fullScreenCover(isPresented: $goToIng, content: sIngredients.init )
            
        }
    }
}
class GifView: UIView {
    var gifName: String? {
        didSet {
            guard let gifName = gifName else { return }
            if let gifURL = Bundle.main.url(forResource: gifName, withExtension: "gif") {
                let imageData = try! Data(contentsOf: gifURL)
                let gifImage = UIImage.gifImageWithData(imageData)
                let imageView = UIImageView(image: gifImage)
                imageView.frame = bounds
                imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                addSubview(imageView)
            }
        }
    }
}
// Helper extension to create UIImage from GIF data
extension UIImage {
    static func gifImageWithData(_ data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("Failed to create image source for GIF")
            return nil
        }
        
        let frameCount = CGImageSourceGetCount(source)
        var images = [UIImage]()
        
        for i in 0..<frameCount {
            guard let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) else {
                print("Failed to create image for GIF frame at index \(i)")
                continue
            }
            
            let image = UIImage(cgImage: cgImage)
            images.append(image)
        }
        
        return UIImage.animatedImage(with: images, duration: 0.0)  }
}


struct sIngredients: View {
    struct Ingredient: Identifiable {
        let id = UUID()
        let name: String
        var position = CGPoint(x: 100, y: 100)
        var dragOffset = CGSize.zero
        var isPlaced = false
    }
    
    @State private var ingredients: [Ingredient] = [
        Ingredient(name: "زعفران"),
        Ingredient(name: "زنجبيل"),
        Ingredient(name: "شمر"),
        Ingredient(name: "قرفة"),
        Ingredient(name: "قهوة مطحونة")
    ]
    @State private var goToIng: Bool = false
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
                            .offset(ingredient.dragOffset)
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
            
            
        }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

//struct pouringPhaseView: View {
//    @State private var waterFillHeight: CGFloat = 0.0
//    @State private var tapCount: Int = 1
//    @State private var isPinned: Bool = false
//    @State private var isPresented:Bool = false
//
//    @State private var showTestingView: Bool = false // Track whether to show the TestingBTN view
//    @State var showAlert = false
//
//
//    var body: some View {
//        VStack {
//            ZStack{
//            ZStack{
//                GifImage("مرحلة الصب")
//                    .frame(width: 988, height: 450)
//                    .offset(x: 40, y: 30)
//
//                ZStack {
//                    CupShape()
//                        .fill(Color.gray)
//                        .frame(width: 110, height: 100)
//                        .opacity(0)
//
//                    WaterShape(fillHeight: waterFillHeight)
//                        .fill(Color.yellow)
//                        .frame(width: 110, height: 90)
//                        .opacity(0.5)
//                        .offset(x: 0, y: -10)
//                        .cornerRadius(20)
//
//                }
//                .offset(x: 160, y: 85)
//
//
//
//
//            }// Zstack
//            .animation(.easeInOut(duration: 1.0)) // Animate the cup filling
//            .onTapGesture(count: 1) {
//                withAnimation {
//                    if waterFillHeight < 1.0 {
//                        waterFillHeight += 0.25 // Increase fill height by 0.2 on each tap
//                        tapCount += 1
//                        if tapCount == 3 {
//                            isPinned = true
//                        }else if tapCount == 4 {
//                            isPinned = false
//                            tapCount = 0
//                            isPresented = true
//                        }
//
//                    }
//                }
//            }
//
//            Button("مـد الفنجال"){
//                if waterFillHeight > 0.0 && waterFillHeight <= 0.5 {
//                    showTestingView = true
//
//                }
//                else {
//                    showTestingView = false
//                    waterFillHeight = 0.0
//                    tapCount = 0
//                    showAlert = true
//
//
//
//                }
//            }
//            .fullScreenCover(isPresented: $showTestingView, content: TestingBTN.init)
//            .alert(isPresented: $showAlert) { () -> Alert in
//                        Alert(title: Text("افا! عيدها"))
//                    }
//            .frame(width: 130, height: 30)
//            .background(Color(red: 0.365, green: 0.13, blue: 0.2))
//            .foregroundColor(.white)
//            .cornerRadius(10)
//            .offset(x: -100, y: 140)
//
//
//
//
//        }//first zsatck
//        }//vstack
//    }//body
//}//struct
//
//
////-------------------
//
//struct TestingBTN: View {
//    var body: some View {
//        VStack{
//            GifImage("اخر صفحة للفوز")
//                .frame(width: 988, height: 450)
//                .offset(x: 40, y: 30)
//        }
//    }
//}
//
////--------------
//
//struct CupShape: Shape {
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//        let topWidth = rect.width * 0.8
//        let bottomWidth = rect.width * 0.6
//        let height = rect.height * 0.8
//
//        path.move(to: CGPoint(x: rect.midX - topWidth/2, y: rect.minY))
//        path.addLine(to: CGPoint(x: rect.midX + topWidth/2, y: rect.minY))
//        path.addLine(to: CGPoint(x: rect.midX + bottomWidth/2, y: rect.minY + height))
//        path.addLine(to: CGPoint(x: rect.midX - bottomWidth/2, y: rect.minY + height))
//        path.closeSubpath()
//
//        return path
//    }
//}
//
////--------------
//
//struct WaterShape: Shape {
//    var fillHeight: CGFloat
//
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//        let topWidth = rect.width * 0.8
//        let bottomWidth = rect.width * 0.4
//
//        let fillHeight = rect.height * (1 - self.fillHeight) // Reverse the fill height
//        let fillY = rect.minY + fillHeight // Adjust the fill Y position
//
//        path.move(to: CGPoint(x: rect.midX - topWidth/2, y: fillY))
//        path.addLine(to: CGPoint(x: rect.midX + topWidth/2, y: fillY))
//        path.addLine(to: CGPoint(x: rect.midX + bottomWidth/2, y: rect.maxY))
//        path.addLine(to: CGPoint(x: rect.midX - bottomWidth/2, y: rect.maxY))
//        path.closeSubpath()
//
//        return path
//    }
//}



