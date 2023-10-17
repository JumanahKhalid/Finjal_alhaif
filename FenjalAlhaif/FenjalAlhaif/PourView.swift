//
//  PourView.swift
//  FenjalAlhaif
//
//  Created by Amwaj Alotaibi on 02/04/1445 AH.
//

import SwiftUI

struct PourView: View {
    @State private var waterFillHeight: CGFloat = 0.0
    @State private var tapCount: Int = 1
    @State private var isPinned: Bool = false
    @State private var isPresented:Bool = false

    @State private var showTestingView: Bool = false // Track whether to show the TestingBTN view
    @State var showAlert = false


    var body: some View {
        VStack {
            ZStack{
            ZStack{
                GifImage("مرحلة الصب")
                    .frame(width: 988, height: 450)
                    .offset(x: 40, y: 30)

                ZStack {
                    CupShape()
                        .fill(Color.gray)
                        .frame(width: 110, height: 100)
                        .opacity(0)

                    WaterShape(fillHeight: waterFillHeight)
                        .fill(Color.yellow)
                        .frame(width: 110, height: 90)
                        .opacity(0.5)
                        .offset(x: 0, y: -10)
                        .cornerRadius(20)

                }
                .offset(x: 160, y: 85)




            }// Zstack
            .animation(.easeInOut(duration: 1.0)) // Animate the cup filling
            .onTapGesture(count: 1) {
                withAnimation {
                    if waterFillHeight < 1.0 {
                        waterFillHeight += 0.25 // Increase fill height by 0.2 on each tap
                        tapCount += 1
                        if tapCount == 3 {
                            isPinned = true
                        }else if tapCount == 4 {
                            isPinned = false
                            tapCount = 0
                            isPresented = true
                        }

                    }
                }
            }

            Button("مـد الفنجال"){
                if waterFillHeight > 0.0 && waterFillHeight <= 0.5 {
                    showTestingView = true

                }
                else {
                    showTestingView = false
                    waterFillHeight = 0.0
                    tapCount = 0
                    showAlert = true



                }
            }
            .fullScreenCover(isPresented: $showTestingView, content: TestingBTN.init)
            .alert(isPresented: $showAlert) { () -> Alert in
                        Alert(title: Text("افا! عيدها"))
                    }
            .frame(width: 130, height: 30)
            .background(Color(red: 0.365, green: 0.13, blue: 0.2))
            .foregroundColor(.white)
            .cornerRadius(10)
            .offset(x: -100, y: 140)




        }//first zsatck
        }//vstack
    }//body
}//struct


//-------------------

struct TestingBTN: View {
    var body: some View {
        VStack{
            GifImage("الشايب")
                .frame(width: 988, height: 450)
                .offset(x: 40, y: 30)
        }
    }
}

//--------------

struct CupShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let topWidth = rect.width * 0.8
        let bottomWidth = rect.width * 0.6
        let height = rect.height * 0.8

        path.move(to: CGPoint(x: rect.midX - topWidth/2, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX + topWidth/2, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX + bottomWidth/2, y: rect.minY + height))
        path.addLine(to: CGPoint(x: rect.midX - bottomWidth/2, y: rect.minY + height))
        path.closeSubpath()

        return path
    }
}

//--------------

struct WaterShape: Shape {
    var fillHeight: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let topWidth = rect.width * 0.8
        let bottomWidth = rect.width * 0.4

        let fillHeight = rect.height * (1 - self.fillHeight) // Reverse the fill height
        let fillY = rect.minY + fillHeight // Adjust the fill Y position

        path.move(to: CGPoint(x: rect.midX - topWidth/2, y: fillY))
        path.addLine(to: CGPoint(x: rect.midX + topWidth/2, y: fillY))
        path.addLine(to: CGPoint(x: rect.midX + bottomWidth/2, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX - bottomWidth/2, y: rect.maxY))
        path.closeSubpath()

        return path
    }
}

