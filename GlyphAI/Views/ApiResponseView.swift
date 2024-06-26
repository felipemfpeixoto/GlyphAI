//
//  ApiResponseView.swift
//  GlyphAI
//
//  Created by infra on 26/06/24.
//

import SwiftUI

struct ApiResponseView: View {
    @State private var isLoading = false
    @State private var fontData: Int = 0
    @State private var showShareSheet = false
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
            
            VStack {
                Rectangle()
                    .foregroundColor(Color.lightGray)
                    .frame(width: 1000, height: 600)
                    .overlay(
                        Rectangle()
                            .inset(by: 2)
                            .stroke(Color.black, lineWidth: 5)
                    )
               
                
                if isLoading {
                    ProgressView("Aguarde...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else if fontData != 0 {
                    ShareLink(item: documentsDirectory.appendingPathComponent("\(fontName).ttf")) {
                        
                    }
                    .padding()
                }
            }
            HStack {
                Spacer()
                Rectangle()
                    .foregroundColor(Color.white)
                    .frame(width: 350, height: 350)
                    .overlay(
                        Rectangle()
                            .inset(by: 2)
                            .stroke(Color.black, lineWidth: 5)
                    )
                Spacer()
                
                VStack {
                    Text("Fonte tal")
                        .font(Font.custom("PixeloidSans-Bold", size: 40).weight(.bold))
                        .foregroundColor(.black)
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
                
                Spacer()
            }
            .padding(.horizontal, 100)
            VStack {
                HStack {
                    Spacer()
                    Image("x")
                        .padding(.trailing, 140)
                }
                .padding(.bottom, 450)
            }
           
        }
        
        .onAppear {
//            fetchData()
        }
    }
    
    func fetchData() {
        isLoading = true
        let caracteres: [Caractere] = [
            Caractere(letra: "A", image: nil, grid: [[0, 1], [1, 0]]),
            Caractere(letra: "B", image: nil, grid: [[1, 0], [0, 1]])
        ]
        
        let fontName = "MinhaFonte"
        
        // Chama a função para criar o JSON com o nome da fonte
        let json = dao.createJSON(fontName: fontName, index: fontIndex)
        fontData = 1
        isLoading = false
        
    }
}

