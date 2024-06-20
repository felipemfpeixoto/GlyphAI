//
//  YourTypographiesView.swift
//  GlyphAI
//
//  Created by Roberta Cordeiro on 20/06/24.
//

import SwiftUI

struct YourTypographiesView: View {
    var body: some View {
        VStack {
                ZStack (alignment: .center){
                   
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(height: 250)
                        .background(Color(red: 0.85, green: 0.85, blue: 0.85))
                        .overlay(
                            Rectangle()
                                .inset(by: 2.5)
                            /Users/robertacordeirosampf/Downloads/pixeloid-font/PixeloidSansBold-PKnYd.ttf         .stroke(.black, lineWidth: 5)
                        )
                    
                    
                    Text("oi roberta")
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .ignoresSafeArea()
        
        }
        
       
        
        
    }
}

#Preview {
    YourTypographiesView()
}
