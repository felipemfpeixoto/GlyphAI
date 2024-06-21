



import SwiftUI

struct YourTypographies: View {
    var body: some View {
        
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
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .edgesIgnoringSafeArea(.all)
        
        VStack {
            HStack {
                Button(action: {}, label: {
                    Image("plus")
                        .padding(.leading, 100)
                })
               
                Spacer()
              
                Text("No added fontes yet")
                   .font(Font.custom("PixeloidSans-Bold", size: 34).weight(.bold))
                   .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))


                Spacer()
                Image("pluswhite")
                    .padding(.trailing, 100)
                    .foregroundColor(.white)

          
                    
              
            }
            Spacer()
        }
        
        
    }
}

#Preview {
    YourTypographies()
}
