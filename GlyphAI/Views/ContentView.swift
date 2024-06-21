//
//  ContentView.swift
//  GlyphAI
//
//  Created by infra on 18/06/24.
//

import CoreML
import SwiftUI
import Photos

struct ContentView: View {
    @State private var grid: [[Bool]] = Array(repeating: Array(repeating: false, count: 16), count: 16)
//    @State var isDragging = false
    @State var lapis: Bool = true
    @State var showSaveAlert = false
    @State var outputImage: UIImage?
    
    var body: some View {
        ZStack {
            VStack {
                Button {
                    print(grid.map({ a in
                        a.map { a in
                            return a ? 0 : 1
                        }
                    }))
                    generateAlphabet()
                } label: {
                    Text("Gerar")
                }
                canvas
            }
            canvasButtons
            HStack {
                Spacer()
                Button {
                    let renderer = ImageRenderer(content: DrawingView(grid: $grid, lapis: lapis, drawGrid: false))
                    let image = renderer.uiImage!
                    PHPhotoLibrary.shared().performChanges({
                        PHAssetChangeRequest.creationRequestForAsset(from: image)
                    }) { success, error in
                        if success {
                            showSaveAlert.toggle()
                        }
                    }
                } label: {
                    Text("Salvar Desenho")
                }
            }
            if let outputImage = self.outputImage {
//                ScrollView(.horizontal) {
                    Image(uiImage: outputImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 400)
//                }
                .onAppear {
                    print(outputImage)
                }
            }
        }
        .alert(isPresented: $showSaveAlert) {
            Alert(title: Text("Desenho Salvo"), message: Text("O desenho foi salvo na galeria"), dismissButton: .default(Text("OK")))
        }
    }
    
    var canvas: some View {
        VStack(spacing: 0) {
            
            DrawingView(grid: $grid, lapis: lapis, drawGrid: true)
            
            Button {
                print(grid)
                zeraTudo()
            } label: {
                Text("Apagar")
            }
        }
    }
    
    var canvasButtons: some View {
        HStack {
            Button {
                lapis.toggle()
            } label: {
                Text("Muda")
            }
            Spacer()
        }
    }
    
    func generateAlphabet() {
        do {
            let config = MLModelConfiguration()
            let model = try MeuModeloFoda(configuration: config)
            let gridConvertido = convertGridToMLMultiArray(grid: grid)
            let input = MeuModeloFodaInput(input_1: gridConvertido!)
            let prediction = try model.prediction(input: input)
            if let outputMultiArray = prediction.featureValue(for: "var_139")?.multiArrayValue {
             
                outputImage = multiArrayToUIImage(outputMultiArray)
            }
        } catch {
            // something went wrong
        }
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
    
    func convertGridToMLMultiArray(grid: [[Bool]]) -> MLMultiArray? {
        // Verifica se o grid não está vazio e possui tamanhos consistentes
        guard let firstRow = grid.first else { return nil }
        let rowCount = grid.count
        let columnCount = firstRow.count

        do {
            // Cria um MLMultiArray de tipo Double com as dimensões corretas
            let multiArray = try MLMultiArray(shape: [1, 1, NSNumber(value: rowCount), NSNumber(value: columnCount)], dataType: .double)
            
            // Percorre o grid e define os valores no MLMultiArray
            for (i, row) in grid.enumerated() {
                for (j, value) in row.enumerated() {
                    multiArray[[0, 0, NSNumber(value: i), NSNumber(value: j)]] = NSNumber(value: value ? 0 : 1)
                }
            }
            print(multiArray)
            return multiArray
        } catch {
            print("Error creating MLMultiArray: \(error)")
            return nil
        }
    }
    
    func multiArrayToUIImage(_ multiArray: MLMultiArray) -> UIImage? {
        
        var array: [Double] = []
        
        let length = multiArray.count
        print(length)
        let posZero = multiArray[100]
        print(posZero)
        
        for i in 0...length - 1 {
            array.append(Double(truncating: multiArray[i]))
        }
        
        if let newArray = reshapeArray(flattenedArray: array, height: 16, width: 416) {
            
            return arrayToGrayscaleImage(array: newArray)
        }
        return nil
        
    }
    
    func arrayToGrayscaleImage(array: [[Double]]) -> UIImage? {
        let height = array.count
        let width = array[0].count
        
        // Create a pixel buffer
        var pixelBuffer = [UInt8](repeating: 0, count: width * height)
        
        for i in 0..<height {
            for j in 0..<width {
                let normalizedValue = UInt8(array[i][j] * 255.0)
                pixelBuffer[i * width + j] = normalizedValue
            }
        }
        
        // Create a CGImage from the pixel buffer
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)
        let bitsPerComponent = 8
        let bytesPerRow = width
        let context = CGContext(data: &pixelBuffer,
                                width: width,
                                height: height,
                                bitsPerComponent: bitsPerComponent,
                                bytesPerRow: bytesPerRow,
                                space: colorSpace,
                                bitmapInfo: bitmapInfo.rawValue)
        
        guard let cgImage = context?.makeImage() else {
            return nil
        }
        
        // Convert the CGImage to a UIImage
        let image = UIImage(cgImage: cgImage)
        
        return image
    }
    
    func reshapeArray(flattenedArray: [Double], height: Int, width: Int) -> [[Double]]? {
        // Check if the total number of elements matches the specified dimensions
        guard flattenedArray.count == height * width else {
            print("The number of elements does not match the specified dimensions.")
            return nil
        }
        
        // Initialize the two-dimensional array
        var reshapedArray: [[Double]] = Array(repeating: Array(repeating: 0, count: width), count: height)
        
        // Fill the two-dimensional array
        for i in 0..<height {
            for j in 0..<width {
                reshapedArray[i][j] = flattenedArray[i * width + j]
            }
        }
        
        return reshapedArray
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
