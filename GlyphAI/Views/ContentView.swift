//
//  ContentView.swift
//  GlyphAI
//
//  Created by infra on 18/06/24.
//

import CoreML
import SwiftUI
import Photos

// Ainda falta adicionar o overlay do tutorial

struct ContentView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var grid: [[Int]] = Array(repeating: Array(repeating: 1, count: 16), count: 16)
//    @State var isDragging = false
    @State var lapis: Bool = true
    @State var showSaveAlert = false
    @State var outputImage: [UIImage]?
    @State var isGenerating: Bool = false
    @State var didGenerate = false
    @State var didReturn = false
    @State var isLoading = false
    @State var fonte: Typographie = Typographie(name: "", characters: [])
    
    let index: Int
    
    var body: some View {
        ZStack {
            canvas
            customBackButton
            canvasButtons
            generateButton
            if isLoading {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                ProgressView()
            }
            if didGenerate {
                ZStack {
                        Color.black.opacity(0.4)
                            .ignoresSafeArea()
                        Button {
                            dao.fonts[index].didGenerate = true
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 25)
                                    .foregroundStyle(.blue)
                                Text("GOOOOOO")
                            }
                        }
                        .frame(width: 350, height: 350)
                }
            }
        }
        .padding(50)
        .onAppear {
            fonte = dao.fonts[index]
        }
        .navigationBarBackButtonHidden()
        .alert(isPresented: $showSaveAlert) {
            Alert(title: Text("Desenho Salvo"), message: Text("O desenho foi salvo na galeria"), dismissButton: .default(Text("OK")))
        }
        .onChange(of: didReturn) {
            DispatchQueue.main.async {
                attributeAllImages()
            }
        }
    }
    
    var canvas: some View {
        VStack(spacing: 0) {
            DrawingView(grid: $grid, lapis: lapis, drawGrid: true)
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
    
    var generateButton: some View {
        VStack {
            Spacer()
            Button {
                generateAlphabet()
                isLoading.toggle()
            } label: {
                ZStack {
                    Rectangle()
                        .foregroundStyle(.gray)
                    Rectangle()
                        .stroke(.black, lineWidth: 3)
                    Text("Generate similar characters")
                        .font(Font.custom("PixeloidSans-Bold", size: 18).weight(.bold))
                        .foregroundStyle(.white)
                }
            }.frame(width: 347, height: 54)
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
                // Aqui cortar a imagem e pegar cada grid
                outputImage = multiArrayToUIImage(outputMultiArray)
                didReturn.toggle()
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
                self.grid[i][j] = 1
            }
        }
    }
    
    func convertGridToMLMultiArray(grid: [[Int]]) -> MLMultiArray? {
        // Verifica se o grid não está vazio e possui tamanhos consistentes
        guard let firstRow = grid.first else { return nil }
        let rowCount = grid.count
        let columnCount = firstRow.count

        do {
            // Cria um MLMultiArray de tipo Double com as dimensões corretas
            let multiArray = try MLMultiArray(shape: [1, 1, NSNumber(value: rowCount), NSNumber(value: columnCount)], dataType: .int32)
            
            // Percorre o grid e define os valores no MLMultiArray
            for (i, row) in grid.enumerated() {
                for (j, value) in row.enumerated() {
                    multiArray[[0, 0, NSNumber(value: i), NSNumber(value: j)]] = NSNumber(value: value)
                }
            }
            return multiArray
        } catch {
            print("Error creating MLMultiArray: \(error)")
            return nil
        }
    }
    
    func multiArrayToUIImage(_ multiArray: MLMultiArray) -> [UIImage]? {
        isGenerating = true
        
        var array: [Double] = []
        
        let length = multiArray.count
        print(length)
        
        for i in 0...length - 1 {
            array.append(Double(truncating: multiArray[i]))
        }
        
        if let newArray = reshapeArray(flattenedArray: array, height: 16, width: 416) {
            // Aqui percorrer o array e atribuir a cada caractere da fonte criada
            let gridSeparadoPorCaractere: [[[Int]]] = cropAndConvertImageGrid(imageGrid: newArray, letterWidth: 16, numberOfLetters: 26)
            
            var i = 0
            var valorRetorno: [UIImage] = []
            for caractere in gridSeparadoPorCaractere {
                // Chamar função do dao para alterar o grid dele
                dao.atribuiGrid(fontIndex: index, characterIndex: i, grid: caractere)
                let image = arrayToGrayscaleImage(array: caractere)!
//                dao.atribuiImage(fontIndex: index, characterIndex: i, image: image.pngData() ?? Data())
                i += 1
            }
            isGenerating = false
            didGenerate = true
            return valorRetorno
        }
        return nil
    }
    
    // Função para realizar o crop vertical
    func cropAndConvertImageGrid(imageGrid: [[Double]], letterWidth: Int, numberOfLetters: Int) -> [[[Int]]] {
        var alphabetGrids: [[[Int]]] = []

        for letterIndex in 0..<numberOfLetters {
            var letterGrid: [[Int]] = []

            for row in imageGrid {
                let startIndex = letterIndex * letterWidth
                let endIndex = startIndex + letterWidth
                let letterRow = row[startIndex..<endIndex].map { $0 > 0.95 ? 1 : 0 }
                letterGrid.append(letterRow)
            }

            alphabetGrids.append(letterGrid)
        }

        return alphabetGrids
    }
    
    func arrayToGrayscaleImage(array: [[Int]]) -> UIImage? {
        let height = array.count
        let width = array[0].count
        
        // Create a pixel buffer
        var pixelBuffer = [UInt8](repeating: 0, count: width * height)
        
        for i in 0..<height {
            for j in 0..<width {
                let normalizedValue = UInt8(array[i][j] * 255)
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
    
    @MainActor func attributeAllImages() {
        isGenerating = true
        for index in dao.fonts[self.index].characters.indices {
            let renderer = ImageRenderer(content: CanvasView(fontIndex: self.index, characterIndex: index, isGenerating: isGenerating))
            let image = renderer.uiImage!
            dao.atribuiImage(fontIndex: self.index, characterIndex: index, image: image.pngData() ?? Data())
        }
        isGenerating = false
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

//#Preview {
//    ContentView()
//}
