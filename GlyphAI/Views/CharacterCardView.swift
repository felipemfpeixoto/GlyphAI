


import SwiftUI

struct CharacterCardView: View {
    
    let characters: [String] = (65...90).map { String(UnicodeScalar($0)!) } // A-Z
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.fixed(196), spacing: 16), count: 5), spacing: 16) {
                ForEach(characters, id: \.self) { character in
                    ZStack(alignment: .bottom) {
                        Rectangle()
                            .foregroundColor(.lightGray)
                            .frame(width: 196, height: 196)
                            .overlay(
                                Rectangle()
                                    .inset(by: 7)
                                    .stroke(Color.black, lineWidth: 5)
                            )
                        
                        VStack {
                            Spacer()
                            Text(character)
                                .font(Font.custom("PixeloidSans-Bold", size: 48).weight(.bold))
                                .foregroundColor(.black)
                            Spacer()
                        }
                        
                        Text(character)
                            .font(Font.custom("PixeloidSans-Bold", size: 24).weight(.bold))
                            .padding(.horizontal, 10)
                            .frame(width: 180)
                            .foregroundColor(.black)
                            .padding(.vertical, 10)
                            .background(Color.mediumGray)
                            .overlay(
                                RoundedRectangle(cornerRadius: 0)
                                    .stroke(Color.black, lineWidth: 2.5)
                            )
                            .padding(.bottom, 3)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Character Grid")
    }
}

#Preview {
    CharacterCardView()
}
