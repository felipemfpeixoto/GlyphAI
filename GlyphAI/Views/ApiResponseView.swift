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
            Color.blue
                .ignoresSafeArea()
            VStack {
                if isLoading {
                    ProgressView("Aguarde...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else if fontData != 0 {
                    ShareLink(item: documentsDirectory.appendingPathComponent("\(fontName).ttf")) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 100)
                                .frame(width: 205, height: 68)
                                .foregroundStyle(.yellow)
                            HStack {
                                Image(systemName: "square.and.arrow.up")
                                    .foregroundStyle(Color.black)
                                    .font(.system(.largeTitle).weight(.semibold))
                                Text("Share TTF")
                                    .foregroundStyle(.black)
                                    .font(.system(.title2))
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            fetchData()
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

