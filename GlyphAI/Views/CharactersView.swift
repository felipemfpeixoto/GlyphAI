import SwiftUI

struct CharactersView: View {
    
    @State var fonte: Typographie
    let index: Int
    
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
                    NavigationLink(destination: YourTypographies()) {
                        Image("customBackButton")
                            .padding(.bottom, 30)
                            .padding(.leading, 60)
                           
                        Spacer()
                    }
                }
                HStack {
                    
                    Text(fonte.name)
                        .font(Font.custom("PixeloidSans-Bold", size: 40).weight(.bold))
                        .padding(.leading, 60)
//                        .padding(.top, 60)
//                        .padding(.bottom, 5)
                    Spacer()
                }
            }
        }
    }
    
    var charactersGrid: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.fixed(196), spacing: 16), count: 5), spacing: 16) {
                ForEach(fonte.characters.indices, id: \.self) { characterIndex in
                    CharacterCardView(character: fonte.characters[characterIndex].letra, fontIndex: index, characterIndex: characterIndex)
                }
            }
            .padding()
        }
        .navigationTitle("Character Grid")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
    }
}




#Preview {
    CharactersView(index: 0)
}
