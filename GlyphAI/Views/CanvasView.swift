//
//  CanvasView.swift
//  GlyphAI
//
//  Created by infra on 22/06/24.
//

import SwiftUI

struct CanvasView: View {
    @Environment(\.dismiss) var dismiss
    
    let fontIndex: Int
    let characterIndex: Int
    let isGenerating: Bool
    
    @State var caractere: Caractere?
    @State var grid: [[Int]] = []
    @State var lapis: Bool = true
    
    @State var isAttributing = false
    
    var body: some View {
        ZStack {
            if grid.count > 0 {
                VStack {
                    Text(caractere?.letra ?? "-")
                        .font(Font.custom("PixeloidSans-Bold", size: 45).weight(.bold))
                    Spacer()
                    DrawingView(grid: $grid, lapis: $lapis, drawGrid: !isGenerating)
                    Spacer()
                }
            }
            if !isGenerating {
                customBackButton
                canvasButtons
            }
            if isAttributing {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                ProgressView("Fetching Changes")
            }
        }
        .navigationBarBackButtonHidden()
        .padding(50)
        .onAppear {
            caractere = dao.fonts[fontIndex].characters[characterIndex]
            grid = (caractere?.grid) ?? [[]]
        }
        .onDisappear {
            dao.atribuiGrid(fontIndex: fontIndex, characterIndex: characterIndex, grid: grid)
        }
    }
    
    var customBackButton: some View {
        VStack {
            HStack {
                Button {
                    DispatchQueue.main.async {
                        atribuiImagem()
                        dismiss()
                    }
                } label: {
                    Image("customBackButton")
                }
                Spacer()
            }
            Spacer()
        }
    }
    
    var canvasButtons: some View {
        VStack {
            HStack(spacing: 0) {
                Button {
                    lapis.toggle()
                } label: {
                    Image(lapis ? "pencilSelected" : "eraserSelected")
                }
                Spacer()
            }
            Spacer()
        }.padding(.vertical, 75)
    }
    
    @MainActor func atribuiImagem() {
        isAttributing = true
        let renderer = ImageRenderer(content: DrawingView(grid: $grid, lapis: $lapis, drawGrid: false))
        let image = renderer.uiImage!
        print(image.pngData())
        dao.atribuiImage(fontIndex: fontIndex, characterIndex: characterIndex, image: image.pngData()!)
        isAttributing = false
    }
}

//#Preview {
//    CanvasView()
//}
