


import SwiftUI

struct TutorialTimeToDrawView: View {
    @State private var typographyName = ""
    
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
                
                ZStack {
                    Image("line2")
                    VStack{
                        Text("Font Generated")
                            .font(Font.custom("PixeloidSans-Bold", size: 20).weight(.bold))
                            .foregroundColor(.black)
                            .padding(.bottom, 15)
                            
                        
                        Text("Your characters are now generated! You can tap on any character to customize it and make adjustments to fit your unique style.")
                            .font(Font.custom("PixeloidSans-Bold", size: 17).weight(.bold))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 370)
                        
                           
                            .padding(.bottom, 15)
                        
                        Text("Enjoy refining your custom font!")
                            .font(Font.custom("PixeloidSans-Bold", size: 17).weight(.bold))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 370)
                            .padding(.bottom, 45)
                            
                    }
                }

                VStack {
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color.lightGray)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .overlay(
                                Rectangle()
                                    .inset(by: 2.5)
                                    .stroke(Color.black, lineWidth: 5)
                            )
                        
                        Text("OK")
                            .font(Font.custom("PixeloidSans-Bold", size: 22).weight(.bold))
                            .foregroundColor(.black)
                    }
                    .frame(width: 173, height: 50)
                    
                    }
                
            }
        }
    }
}


#Preview {
    TutorialTimeToDrawView()
}
