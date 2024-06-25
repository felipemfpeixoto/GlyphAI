//
//  DrawingView.swift
//  GlyphAI
//
//  Created by infra on 20/06/24.
//

import SwiftUI

struct DrawingView: View {
    @Binding var grid: [[Int]]
    var lapis: Bool
    var drawGrid: Bool
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ForEach(0..<16, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<16, id: \.self) { column in
                            Rectangle()
                                .fill(self.grid[row][column] == 0 ? Color.black : drawGrid ? Color.ourLightGray : .lightGray)
                                .frame(width: 30, height: 30)
                                .border(Color.gray, width: drawGrid ? 1 : 0)
                                .gesture(DragGesture(minimumDistance: 0)
                                    .onChanged { hey in
                                        let location = hey.location
                                        let xLocation = location.x
                                        let yLocation = location.y
                                        let xAdd = column + Int(xLocation/30)
                                        let yAdd = row + Int(yLocation/30)
                                        guard xAdd > -1 && xAdd < 16 else {return}
                                        guard yAdd > -1 && yAdd < 16 else {return}
                                        print(xAdd)
                                        print(yAdd)
                                        self.grid[row + Int(yLocation/30)][column + Int(xLocation/30)] = lapis ? 0 : 1
                                    }
                                         //                            .onEnded { _ in
                                         //                                self.isDragging = false
                                         //                            }
                                )
                        }
                    }
                }
            }.border(.black, width: drawGrid ? 3 : 0)
        }
    }
}

#Preview {
    DrawingView(grid: .constant(Array(repeating: Array(repeating: 1, count: 16), count: 16)), lapis: true, drawGrid: true)
}
