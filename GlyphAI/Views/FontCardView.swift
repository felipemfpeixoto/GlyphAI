//
//  FontCardView.swift
//  GlyphAI
//
//  Created by Roberta Cordeiro on 21/06/24.
//

import SwiftUI

struct FontCardView: View {
    
    let fonte: Typographie
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .foregroundColor(.lightGray)
                .frame(width: 260, height: 260)
                .overlay(
                    Rectangle()
                        .inset(by: 2.5)
                        .stroke(Color.black, lineWidth: 5)
                )
                .overlay(
                    VStack {
                        HStack {
                            Spacer()
                            Button(action: {
                                // Ação do botão
                                print("Botão pressionado")
                            }) {
                                Image("lixeira")
                                    .resizable()
                                    .frame(width: 36, height: 45)
                                    .foregroundColor(.black)
                            }
                            .padding([.top, .trailing], 10)
                        }
                        Spacer()
                    }
                )
            
            Text(fonte.name)
                .font(Font.custom("PixeloidSans-Bold", size: 24).weight(.bold))
                .padding(.horizontal, 10)
                .frame(width: 250) // Garante que
                .padding(.vertical, 10)
                .background(Color.gray)
                .overlay(
                    RoundedRectangle(cornerRadius: 0)
                        .stroke(Color.black, lineWidth: 2.5)
                )
                .padding(.bottom, 3)
        }
        .frame(width: 260, height: 260) // Garante que o ZStack tenha o mesmo tamanho que o retângulo
    }
}



#Preview {
    FontCardView(fonte: Typographie(name: "Mengo", characters: []))
}
