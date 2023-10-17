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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewInterfaceOrientation(.landscapeLeft)
        
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
