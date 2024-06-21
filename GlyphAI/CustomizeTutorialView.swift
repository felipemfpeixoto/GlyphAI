//
//  CustomizeTutorialView.swift
//  GlyphAI
//
//  Created by Roberta Cordeiro on 21/06/24.
//

import SwiftUI

struct CustomizeTutorialView: View {
    @State private var typographyName = ""
    
    var body: some View {
        ZStack {
            Image("dottedbackground")
                .padding(.top, 35)
                .padding(.leading, 35)
            
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 577, height: 335)
                .background(.white)
                .overlay(
                    Rectangle()
                        .inset(by: 2.5)
                        .stroke(.black, lineWidth: 5)
                    
                )
            
            VStack {
                
                ZStack {
                    Image("line2")
                    VStack{
                        Text("Let's Customize")
                            .font(Font.custom("PixeloidSans-Bold", size: 18).weight(.bold))
                            .padding(.bottom, 30)
                        
                        Text("Your characters are now generated! Click on any character to customize it and make adjustments to fit your unique style. ")
                            .font(Font.custom("PixeloidSans-Bold", size: 16).weight(.bold))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 480)
                            .padding(.bottom, 15)
                        
                        Text("Enjoy refining your custom font")
                            .font(Font.custom("PixeloidSans-Bold", size: 16).weight(.bold))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 480)
                            .padding(.bottom, 40)
                            
                    }
                }

                VStack {
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color.lightGray)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .overlay(
                                Rectangle()
                                    .inset(by: 2.5)
                                    .stroke(Color.black, lineWidth: 5)
                            )
                        
                        Text("OK")
                            .font(Font.custom("PixeloidSans-Bold", size: 22).weight(.bold))
                            .foregroundColor(.black)
                    }
                    .frame(width: 173, height: 50)
                    
                    }
                
            }
        }
    }
}



#Preview {
    CustomizeTutorialView()
}
