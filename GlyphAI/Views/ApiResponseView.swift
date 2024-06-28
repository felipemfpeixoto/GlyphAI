//
//  ApiResponseView.swift
//  GlyphAI
//
//  Created by infra on 26/06/24.
//

import SwiftUI

struct ApiResponseView: View {
    @State private var isLoading = true
    @State private var fontData: Int = 0
    @State private var showShareSheet = false
    @Binding var isShowingSelf: Bool
    let fontName: String
    let fontIndex: Int
    var documentsDirectory: URL {
                FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            }
    
    var body: some View {
        ZStack {
            
            Image("dottedbackground2")
                .padding(.leading, 60)
                .padding(.top, 35)
            Rectangle()
                .foregroundColor(Color.lightGray)
                .frame(width: 1000, height: 600)
                .overlay(
                    Rectangle()
                        .inset(by: 2)
                        .stroke(Color.black, lineWidth: 5)
                )
            ZStack {
                HStack {
                    ZStack {
                        Image(uiImage: UIImage(data: dao.fonts[fontIndex].characters[0].image!)!)
                            .resizable()
                            .frame(width: 350, height: 350)
                            .scaledToFit()
                            .overlay(
                                Rectangle()
                                    .inset(by: 2)
                                    .stroke(Color.black, lineWidth: 5)
                            )
                    }
                    Spacer()
                    if isLoading {
                        ProgressView("Generating your font file...")
                            .progressViewStyle(CircularProgressViewStyle())
                            .foregroundStyle(.black)
                            .font(Font.custom("PixeloidSans-Bold", size: 20).weight(.bold))
                    } else if fontData != 0 {
                        VStack {
                            Text("\(dao.fonts[fontIndex].name).ttf")
                                .font(Font.custom("PixeloidSans-Bold", size: 40).weight(.bold))
                                .foregroundColor(.black)
                            ShareLink(item: documentsDirectory.appendingPathComponent("\(fontName).ttf")) {
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(Color.mediumGray)
                                        .frame(width: 200, height: 50)
                                        .overlay(
                                            Rectangle()
                                                .inset(by: 2.5)
                                                .stroke(Color.black, lineWidth: 5)
                                        )
                                    HStack {
                                        Image("share")
                                            .padding(.horizontal, 8)
                                        
                                        Text("Share TTF")
                                            .font(Font.custom("PixeloidSans-Bold", size: 18).weight(.bold))
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 200)
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            isShowingSelf.toggle()
                        } label: {
                            Image("x")
                        }
                        
                    }
                    Spacer()
                }.padding(150)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                fetchData()
            }
        }
    }
    
    func fetchData() {
        // Chama a função para criar o JSON com o nome da fonte
        let json = dao.createJSON(fontName: fontName, index: fontIndex)
        fontData = 1
        isLoading = false
        
    }
}

