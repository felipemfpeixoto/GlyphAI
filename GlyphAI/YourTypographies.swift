



import SwiftUI

struct YourTypographies: View {
    var body: some View {
        ZStack {
                    Rectangle()
                        .foregroundColor(Color(red: 0.85, green: 0.85, blue: 0.85))
                        .frame(height: 250)
                        .overlay(
                            Rectangle()
                                .inset(by: 2.5)
                                .stroke(Color.black, lineWidth: 5)
                        )
            VStack {
                HStack {
                    Text("Your typographies")
                        .font(Font.custom("PixeloidSans-Bold", size: 18).weight(.bold))
                        .padding(.leading, 100)
                        .padding(.top, 25)
                    Spacer()
                    
                }
                HStack {
                    Text("Hi")
                        .font(Font.custom("PixeloidSans-Bold", size: 18).weight(.bold))
                        .padding(.leading, 100)
//                        .onAppear {
//                            for family in UIFont.familyNames.sorted() {
//                                let names = UIFont.fontNames(forFamilyName: family)
//                                print("Family: \(family) Font names: \(names)")
//                            }
//                        }
//                        .padding(.top, 25)
                    Spacer()
                    Spacer()
                    
                }
            }
                   
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // Alinha ao topo e à esquerda
                .edgesIgnoringSafeArea(.all) // Ignora a área segura para ocupar toda a tela
            }
}

#Preview {
    YourTypographies()
}
