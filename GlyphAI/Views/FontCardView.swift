import SwiftUI

struct FontCardView: View {
    
    @State var fonte: Typographie = Typographie(name: "", characters: [])
    
    let index: Int
    let onDelete: (Int) -> Void
    
    var body: some View {
        NavigationLink(destination: fonte.didGenerate ? AnyView(CharactersView(index: index)) : AnyView(AuxView(index: index))) {
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
                                    onDelete(index)
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
                    .frame(width: 250)
                    .foregroundStyle(.black)
                    .padding(.vertical, 10)
                    .background(Color.mediumGray)
                    .overlay(
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(Color.black, lineWidth: 2.5)
                    )
                    .padding(.bottom, 3)
            }
            .frame(width: 260, height: 260)
        }
        .onAppear {
            fonte = dao.fonts[index]
        }
    }
}
