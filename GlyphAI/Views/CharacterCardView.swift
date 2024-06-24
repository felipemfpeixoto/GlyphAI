


import SwiftUI

struct CharacterCardView: View {
    
    let character: String
    let fontIndex: Int
    let characterIndex: Int
    
    var body: some View {
        NavigationLink(destination: CanvasView(fontIndex: fontIndex, characterIndex: characterIndex)) {
            ZStack(alignment: .bottom) {
                Rectangle()
                    .foregroundColor(.lightGray)
                    .frame(width: 196, height: 196)
                    .overlay(
                        Rectangle()
                            .stroke(Color.black, lineWidth: 5)
                            .frame(width: 196, height: 196)
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
                    .frame(width: 193)
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
}


//#Preview {
//    CharacterCardView()
//}
