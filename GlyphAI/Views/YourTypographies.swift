import SwiftUI

struct YourTypographies: View {
    
    @State var isSHowingCreate = false
    
    var body: some View {
        ZStack {
            VStack {
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
                            Text("Your typographies")
                                .font(Font.custom("PixeloidSans-Bold", size: 40).weight(.bold))
                                .padding(.leading, 100)
                                .padding(.top, 60)
                                .padding(.bottom, 5)
                            Spacer()
                            
                        }
                        
                    }
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Button(action: {
                            // mostrar o sheet para criar nova tipografia
                            isSHowingCreate.toggle()
                        }, label: {
                            Image("plus")
                        })
                        
                        if dao.fonts.count == 0 {
                            Text("No added fontes yet")
                                .font(Font.custom("PixeloidSans-Bold", size: 34).weight(.bold))
                                .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                        } else {
                            ForEach(dao.fonts, id: \.self.name) { fonte in
                                FontCardView(fonte: fonte)
                            }
                        }
                    }
                    Spacer()
                }
            }
            
            if isSHowingCreate {
                ZStack {
                    Color.black.opacity(0.4)
                    CreateFontView(isSHowing: $isSHowingCreate)
                }
            }
        }
        
    }
}

#Preview {
    YourTypographies()
}
