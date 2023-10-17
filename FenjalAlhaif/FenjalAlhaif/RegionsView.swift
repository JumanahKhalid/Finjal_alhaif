//
//  RegionsView.swift
//  FenjalAlhaif
//
//  Created by jumanah khalid albisher on 01/04/1445 AH.


import SwiftUI

struct RegionsView: View {
    @StateObject private var audioPlayerManager = AudioPlayerManager.shared
    @State var selectedRegion: String = ""
    @State private var isNextPageActive = false
    @State private var isPlaying = false
    var body: some View {
        NavigationStack {
            HStack {
                ZStack {
                    GifBackground(gifName: "# 2 Options page")
                    
                    Button("المنطقة الوسطى") {
                        selectedRegion = "Najed"
                    }
                    .font(.system(size: 20))
                    .buttonStyle(.bordered)
                    .tint(.clear)
                    .offset(x: 10, y: 55)
                    
                                          NavigationLink(
                                              destination: NajdRegion(gifName: "oven1"),
                                              isActive: Binding<Bool>(
                                                  get: { selectedRegion == "Najed" },
                                                  set: { isActive in
                                                      if !isActive {
                                                          selectedRegion = ""
                                                      }
                                                  }
                                              ),
                                              label: { EmptyView() }
                                          )
                    
                    Button("المنطقة الشمالية") {
                        selectedRegion = "Shamaliah"
                    }
                    .font(.system(size: 20))
                    .buttonStyle(.bordered)
                    .tint(.clear)
                    .offset(x: 240, y: 55)
                    
                                          NavigationLink(
                                              destination: ShamaliahRegion(gifName: "oven1"),
                                              isActive: Binding<Bool>(
                                                  get: { selectedRegion == "Shamaliah" },
                                                  set: { isActive in
                                                      if !isActive {
                                                          selectedRegion = ""
                                                      }
                                                  }
                                              ),
                                              label: { EmptyView() }
                                          )
                    
                    Button("المنطقة الجنوبية") {
                        selectedRegion = "Janob"
                    }
                    .font(.system(size: 20))
                    .buttonStyle(.bordered)
                    .tint(.clear)
                    .offset(x: -240, y: 55)
                    
                                          NavigationLink(
                                              destination: JanobRegion(gifName: "oven1"),
                                              isActive: Binding<Bool>(
                                                  get: { selectedRegion == "Janob" },
                                                  set: { isActive in
                                                      if !isActive {
                                                          selectedRegion = ""
                                                      }
                                                  }
                                              ),
                                              label: { EmptyView() }
                                          )
                                      }
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
            }
            .edgesIgnoringSafeArea(.all)
        }
    }

