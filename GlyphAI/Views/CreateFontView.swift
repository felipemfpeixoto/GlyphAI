

import SwiftUI

struct CreateFontView: View {
    @State private var typographyName = ""
    
    @Binding var isSHowing: Bool
    
    var body: some View {
        ZStack {
            Image("dottedbackground")
                .padding(.top, 35)
                .padding(.leading, 35)
            
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 577, height: 335)
                .background(.white)
            
            
                .overlay(
                    Rectangle()
                        .inset(by: 2.5)
                        .stroke(.black, lineWidth: 5)
                    
                )
            
            VStack {
                Text("Create your new typography")
                    .font(Font.custom("PixeloidSans-Bold", size: 24).weight(.bold))
                    .padding(.bottom, 30)
                ZStack {
                    Image("line")
                    VStack{
                        Text("Name your font:")
                            .font(Font.custom("PixeloidSans-Bold", size: 18).weight(.bold))
                            .padding(.bottom, 20)
                        TextField(" |", text: $typographyName)
                            .font(Font.custom("PixeloidSans-Bold", size: 21).weight(.bold))
                            .foregroundStyle(.black)
                            .background(Color.lightGray)
                            .border(Color.black, width: 2)
                            .font(.system(.title))
                            .frame(width: 430)
                            .padding(.bottom, 60)
                    }
                    
                }
                
                
                
                
                
                HStack {
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(.white) // Cor de fundo cinza
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .overlay(
                                Rectangle()
                                    .inset(by: 2.5)
                                    .stroke(Color.black, lineWidth: 5) // Traçado preto
                            )
                        
                        Text("Cancel")
                            .font(Font.custom("PixeloidSans-Bold", size: 20).weight(.bold))
                            .foregroundColor(.black) // Cor do texto
                    }
                    .frame(width: 173, height: 50)
                    .padding(.horizontal, 10)
                    
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color.lightGray) // Cor de fundo cinza
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .overlay(
                                Rectangle()
                                    .inset(by: 2.5)
                                    .stroke(Color.black, lineWidth: 5) // Traçado preto
                            )
                        
                        Button {
                            if typographyName != "" { // Gambiarra, fazer direito depois
                                dao.createNewFont(name: typographyName)
                            }
                            isSHowing.toggle()
                        } label: {
                            Text("Create")
                                .font(Font.custom("PixeloidSans-Bold", size: 22).weight(.bold))
                                .foregroundColor(.black) // Cor do texto
                        }

                        
                    }
                    .frame(width: 173, height: 50)
                    .padding(.horizontal, 10)
                }
                
            }
        }
    }
}


#Preview {
    CreateFontView(isSHowing: .constant(true))
}
