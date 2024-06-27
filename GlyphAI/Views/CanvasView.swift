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
    
    var body: some View {
        ZStack {
            if grid.count > 0 {
                VStack {
                    Text(caractere?.letra ?? "-")
                    Spacer()
                        .font(Font.custom("PixeloidSans-Bold", size: 45).weight(.bold))
                    DrawingView(grid: $grid, lapis: true, drawGrid: !isGenerating)
                    Spacer()
                }
            }
            if !isGenerating {
                customBackButton
                canvasButtons
            }
        }
        .navigationBarBackButtonHidden()
        .padding(50)
        .onAppear {
            caractere = dao.fonts[fontIndex].characters[characterIndex]
            grid = (caractere?.grid) ?? [[]]
        }
        .onDisappear {
            
        }
    }
    
    var customBackButton: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
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
    
    func attributeGrid() {
        dao.atribuiGrid(fontIndex: fontIndex, characterIndex: characterIndex, grid: grid)
    }
}

//#Preview {
//    CanvasView()
//}
