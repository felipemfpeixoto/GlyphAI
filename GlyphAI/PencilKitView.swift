//
//  PencilKitView.swift
//  GlyphAI
//
//  Created by infra on 18/06/24.
//

import SwiftUI
import PencilKit

struct DrawingView: UIViewRepresentable {
    @Binding var canvasView: PKCanvasView

    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.drawingPolicy = .anyInput
        return canvasView
    }

    func updateUIView(_ uiView: PKCanvasView, context: Context) {
    }
}

struct PencilKitView: View {
    @State private var canvasView = PKCanvasView()
    @State private var showSaveAlert = false
    @State private var savedImagePath: String? = nil
    
    var body: some View {
        VStack {
            DrawingView(canvasView: $canvasView)
                .frame(width: 320, height: 320)
                .border(Color.black, width: 2) // Adiciona uma borda preta de 2 pontos
            
            Button(action: saveDrawingToPhotoAlbum) {
                Text("Salvar Desenho")
            }
            .alert(isPresented: $showSaveAlert) {
                Alert(title: Text("Desenho Salvo"), message: Text("O desenho foi salvo na galeria. Caminho: \(savedImagePath ?? "N/A")"), dismissButton: .default(Text("OK")))
            }
        }
        .padding() // Adiciona algum padding ao redor da VStack
    }
    
    func saveDrawingToPhotoAlbum() {
            let image = canvasView.drawing.image(from: canvasView.bounds, scale: 1.0)
            let resizedImage = resizeImage(image: image, targetSize: CGSize(width: 64, height: 64))
            
            // Obter o caminho do diretório de documentos
            let fileManager = FileManager.default
            guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
                print("Não foi possível acessar o diretório de documentos.")
                return
            }
            
            // Caminho completo para o arquivo de imagem
            let filePath = documentsDirectory.appendingPathComponent("desenho.png")
            
            // Salvar a imagem no diretório de documentos
            if let imageData = resizedImage.pngData() {
                do {
                    try imageData.write(to: filePath)
                    savedImagePath = filePath.path
                    print("Imagem salva em: \(filePath.path)")
                    
                    // Salvar na galeria de fotos
                    let imageSaver = ImageSaver()
                    imageSaver.writeToPhotoAlbum(image: resizedImage) { success, error in
                        if success {
                            print("Imagem adicionada à galeria com sucesso.")
                        } else if let error = error {
                            print("Erro ao adicionar imagem à galeria: \(error.localizedDescription)")
                        }
                    }
                    
                    showSaveAlert = true
                } catch {
                    print("Erro ao salvar a imagem: \(error.localizedDescription)")
                }
            }
        }
        
        func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
            let renderer = UIGraphicsImageRenderer(size: targetSize)
            return renderer.image { _ in
                image.draw(in: CGRect(origin: .zero, size: targetSize))
            }
        }
}

#Preview {
    PencilKitView()
}
