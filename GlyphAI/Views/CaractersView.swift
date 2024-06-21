//
//  CaractersView.swift
//  GlyphAI
//
//  Created by Roberta Cordeiro on 21/06/24.
//

import SwiftUI

struct CaractersView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(red: 0.95, green: 0.95, blue: 0.95))
                .frame(height: 250)
                .overlay(
                    Rectangle()
                        .inset(by: 2.5)
                        .stroke(Color.black, lineWidth: 5)
                )
            VStack {
                HStack {
                    Text("Your typographies")
                        .font(Font.custom("PixeloidSans-Bold", size: 40).weight(.bold))
                        .padding(.leading, 100)
                        .padding(.top, 60)
                        .padding(.bottom, 5)
                    Spacer()
                    
                }
                
            }
        }
    }
}

#Preview {
    CaractersView()
}
