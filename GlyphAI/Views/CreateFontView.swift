

import SwiftUI

struct CreateFontView: View {
    @State private var typographyName = ""
    
    @Binding var isSHowing: Bool
    @ObservedObject private var keyboard = KeyboardResponder()
    
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
                            .frame(width: 430, height: 40)
                            .background(Color.lightGray)
                            .border(Color.black, width: 2)
                            .font(.system(.title))
                            .padding(.horizontal, 15)
                    }
                }
                
                
                
                
                
                HStack {
                    
                    Button {
                        isSHowing.toggle()
                    } label: {
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
        .padding(.bottom, keyboard.keyboardHeight / 3) // Move a VStack para cima quando o teclado aparece
        .animation(.easeOut(duration: 0.25)) // Anima a transição
    }
}

import SwiftUI
import Combine

class KeyboardResponder: ObservableObject {
    private var cancellable: AnyCancellable?
    @Published private(set) var keyboardHeight: CGFloat = 0
    
    init() {
        // Observa mudanças no tamanho do teclado
        cancellable = NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .compactMap { notification in
                guard let userInfo = notification.userInfo,
                      let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
                      let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {
                    return nil
                }
                return keyboardFrame.height - window.safeAreaInsets.bottom
            }
            .assign(to: \.keyboardHeight, on: self)
    }
}


#Preview {
    CreateFontView(isSHowing: .constant(true))
}
