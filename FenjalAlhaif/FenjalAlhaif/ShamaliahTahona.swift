//
//   ShamaliahTahona.swift
//  FenjalAlhaif
//
//  Created by Amwaj Alotaibi on 02/04/1445 AH.
//

import SwiftUI

struct ShamaliahTahona: View {
    var body: some View {
        ZStack{
            
            ZStack{
                GifBackground(gifName: "خلفية الطاحونة")
                sVibrationView()
            }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
           
            
            
        }
    }
}
