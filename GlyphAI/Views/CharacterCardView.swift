


import SwiftUI

struct CharacterCardView: View {
    
    let character: Caractere
    let fontIndex: Int
    let characterIndex: Int
    
    var body: some View {
        NavigationLink(destination: CanvasView(fontIndex: fontIndex, characterIndex: characterIndex, isGenerating: false)) {
            ZStack(alignment: .bottom) {
                Rectangle()
                    .foregroundColor(.lightGray)
                Rectangle()
                    .stroke(Color.black, lineWidth: 5)
                VStack {
                    Spacer()
                    Image(uiImage: UIImage(data: character.image ?? Data())!)
                        .resizable()
                        .frame(width: 80)
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(Color.black, lineWidth: 2.5)
                        Text(character.letra)
                            .font(Font.custom("PixeloidSans-Bold", size: 24).weight(.bold))
                            .foregroundColor(.black)
                            .background(Color.mediumGray)
                    }
                    .frame(width: 193)
                }
            }
            .frame(width: 196, height: 196)
        }
    }
}


//#Preview {
//    CharacterCardView(character: Caractere(letra: "A"), fontIndex: 0, characterIndex: 0)
//}
