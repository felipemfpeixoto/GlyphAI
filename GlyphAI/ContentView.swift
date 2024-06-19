//
//  ContentView.swift
//  GlyphAI
//
//  Created by infra on 18/06/24.
//

import SwiftUI
import Photos

struct ContentView: View {
    @State private var grid: [[Bool]] = Array(repeating: Array(repeating: false, count: 64), count: 64)
//    @State var isDragging = false
    @State var lapis: Bool = true
    @State var showSaveAlert = false
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Button {
                lapis.toggle()
            } label: {
                Text("Muda")
            }
            Spacer()
            
            DrawingGridView(grid: $grid, lapis: lapis, drawGrid: true)
            
            Button {
                zeraTudo()
            } label: {
                Text("Apagar")
            }

            Spacer()
            Button {
//                saveDrawingToPhotoAlbum()
                let renderer = ImageRenderer(content: DrawingGridView(grid: $grid, lapis: lapis, drawGrid: false))
                let image = renderer.uiImage!
                PHPhotoLibrary.shared().performChanges({
                    PHAssetChangeRequest.creationRequestForAsset(from: image)
                }) { success, error in
                    print(success, error)
                }
            } label: {
                Text("Salvar Desenho")
            }
        }
        .alert(isPresented: $showSaveAlert) {
            Alert(title: Text("Desenho Salvo"), message: Text("O desenho foi salvo na galeria"), dismissButton: .default(Text("OK")))
        }
    }
    
    func saveDrawingToPhotoAlbum() {
        let image = snapshot()
        let imageSaver = ImageSaver()
//        imageSaver.writeToPhotoAlbum(image: image)
        showSaveAlert = true
    }
    
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
    
    func zeraTudo() {
        for i in 0..<16 {
            for j in 0..<16 {
                self.grid[i][j] = false
            }
        }
    }
}

// Salvando a imagem
class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage, completion: @escaping (Bool, Error?) -> Void) {
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: image)
        }) { success, error in
            completion(success, error)
        }
    }
}

struct SnapshotView: UIViewRepresentable {
    var content: UIView

    func makeUIView(context: Context) -> UIView {
        return content
    }

    func updateUIView(_ uiView: UIView, context: Context) {
    }
}

extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}

#Preview {
    ContentView()
}

struct DrawingGridView: View {
    @Binding var grid: [[Bool]]
    var lapis: Bool
    var drawGrid: Bool
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<16, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0..<16, id: \.self) { column in
                        Rectangle()
                            .fill(self.grid[row][column] ? Color.black : Color.white)
                            .frame(width: 30, height: 30)
                            .border(Color.gray, width: drawGrid ? 1 : 0)
                            .gesture(DragGesture(minimumDistance: 0)
                                .onChanged { hey in
                                    let location = hey.location
                                    let xLocation = location.x
                                    let yLocation = location.y
                                    let xAdd = column + Int(xLocation/30)
                                    let yAdd = row + Int(yLocation/30)
                                    guard xAdd > -1 && xAdd < 32 else {return}
                                    guard yAdd > -1 && yAdd < 32 else {return}
                                    print(xAdd)
                                    print(yAdd)
                                    self.grid[row + Int(yLocation/30)][column + Int(xLocation/30)] = lapis
                                }
                                     //                            .onEnded { _ in
                                     //                                self.isDragging = false
                                     //                            }
                            )
                    }
                }
            }
        }
    }
}
