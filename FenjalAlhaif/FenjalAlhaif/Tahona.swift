//
//  Tahona.swift
//  FenjalAlhaif
//
//  Created by jumanah khalid albisher on 01/04/1445 AH.
//

import SwiftUI

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
