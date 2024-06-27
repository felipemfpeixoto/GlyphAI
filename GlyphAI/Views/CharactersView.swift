import SwiftUI

struct CharactersView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var fonte: Typographie
    let index: Int
    @State var isExporting = false
    
    init(index: Int) {
        self.index = index
        self.fonte = dao.fonts[index]
    }
    
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
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
        .fullScreenCover(isPresented: $isExporting, content: {
            ApiResponseView(fontName: dao.fonts[index].name, fontIndex: index)
        })
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
                    Button {
                        dismiss()
                    } label: {
                        Image("customBackButton")
                            .padding(.bottom, 30)
                            .padding(.leading, 60)
                    }
                    Spacer()
                }
                HStack {
                    
                    Text(fonte.name)
                        .font(Font.custom("PixeloidSans-Bold", size: 40).weight(.bold))
                        .padding(.leading, 60)
//                        .padding(.top, 60)
//                        .padding(.bottom, 5)
                    Spacer()
                    Button {
                        isExporting = true
                    } label: {
                        Text("Export TTF")
                    }

                }
            }
        }
    }
    
    var charactersGrid: some View {
        ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.fixed(196), spacing: 16), count: 5), spacing: 16) {
                    ForEach(Array(fonte.characters.enumerated()), id: \.element.letra) { characterIndex, character in
                        CharacterCardView(character: character, fontIndex: index, characterIndex: characterIndex)
                    }
                }
            .padding()
        }
    }
}




#Preview {
    CharactersView(index: 0)
}
