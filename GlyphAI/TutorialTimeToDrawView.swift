


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
                        Text("Time to Draw")
                            .font(Font.custom("PixeloidSans-Bold", size: 18).weight(.bold))
                            .padding(.bottom, 20)
                        
                        Text("Draw your first letter on the pixel grid. GliphAI will then generate the remaining characters for you, maintaining the same style.")
                            .font(Font.custom("PixeloidSans-Bold", size: 16).weight(.bold))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 480)
                            .padding(.bottom, 15)
                        
                        Text("Get started and watch your custom font come to life!")
                            .font(Font.custom("PixeloidSans-Bold", size: 16).weight(.bold))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 480)
                            .padding(.bottom, 30)
                            
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
            .frame(width: 577, height: 335)
        }
    }
}


#Preview {
    TutorialTimeToDrawView()
}
