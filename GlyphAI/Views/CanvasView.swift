//
//  CanvasView.swift
//  GlyphAI
//
//  Created by infra on 22/06/24.
//

import SwiftUI

struct CanvasView: View {
    
    let fontIndex: Int
    let characterIndex: Int
    
    @State var caractere: Character?
    @State var grid: [[Int]] = []
    
    var body: some View {
        ZStack {
            if grid.count > 0 {
                DrawingView(grid: $grid, lapis: true, drawGrid: true)
            }
        }
        .onAppear {
            caractere = dao.fonts[fontIndex].characters[characterIndex]
            print(dao.fonts[fontIndex].name, caractere)
            grid = (caractere?.grid)!
        }
    }
}

//#Preview {
//    CanvasView()
//}
