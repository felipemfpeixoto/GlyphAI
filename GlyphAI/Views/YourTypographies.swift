import SwiftUI

struct YourTypographies: View {
    
    @State var isSHowingCreate = false
    
    var body: some View {
        ZStack {
            VStack {
                header
                Spacer()
                content
                Spacer()
            }
            if isSHowingCreate {
                ZStack {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                    CreateFontView(isSHowing: $isSHowingCreate)
                }
            }
        }.ignoresSafeArea()
    }
    
    var header: some View {
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
    }
    
    var content: some View {
        ZStack {
            HStack {
                ScrollView(.horizontal) {
                    HStack(spacing: 25) {
                        Button(action: {
                            isSHowingCreate.toggle()
                        }, label: {
                            Image("plus")
                        }).padding(.horizontal, 100)
                        
                        if dao.fonts.count != 0 {
                            ForEach(dao.fonts.indices, id: \.self) { index in
                                FontCardView(index: index, onDelete: { indexToDelete in
                                    dao.deleteFont(at: indexToDelete)
                                })
                            }
                        }
                    }
                }
            }
            if dao.fonts.count == 0 {
                Text("No added fonts yet")
                    .font(Font.custom("PixeloidSans-Bold", size: 34).weight(.bold))
                    .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
            }
        }
    }
}

#Preview {
    YourTypographies()
}
