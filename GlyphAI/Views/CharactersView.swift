//
//  CaractersView.swift
//  GlyphAI
//
//  Created by Roberta Cordeiro on 21/06/24.
//

import SwiftUI

struct CharactersView: View {
    
    @State var fonte: Typographie = Typographie(name: "", characters: [])
    
    let letrasMaiusculas: [String] = [
            "A", "B", "C", "D", "E", "F", "G", "H", "I", "J",
            "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",
            "U", "V", "W", "X", "Y", "Z",
            "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"
        ]
    
    let itemsPerRow = 5
    let spacing: CGFloat = 30 // Espaçamento entre os quadrados
    let itemSize: CGFloat = UIScreen.main.bounds.width / 6 // Tamanho dos quadrados
    
    let index: Int
    
    var body: some View {
        ZStack {
            VStack {
                header
                Spacer()
                if fonte.characters.count > 0 {
                    charactersGrid
                }
            }
        }
//        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
        .onAppear {
            fonte = dao.fonts[index]
        }
    }
    
    var header: some View {
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
                        Text(fonte.name)
                            .font(Font.custom("PixeloidSans-Bold", size: 40).weight(.bold))
                            .padding(.leading, 100)
                            .padding(.top, 60)
                            .padding(.bottom, 5)
                        Spacer()
                        
                    }
                    
                }
            }
    }
    
    var charactersGrid: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.fixed(itemSize), spacing: spacing), count: Int(itemsPerRow)), spacing: spacing) {
            ForEach(fonte.characters.indices) { characterIndex in
                NavigationLink(destination: CanvasView(fontIndex: index, characterIndex: characterIndex)) {
                    Text(fonte.characters[characterIndex].letra)
                }
            }
        }
    }
}

//#Preview {
//    CharactersView()
//}
