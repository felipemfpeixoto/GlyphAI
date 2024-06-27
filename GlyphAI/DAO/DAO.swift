import Foundation
import CodableExtensions
import UIKit

@Observable
class DAO: Codable {
    static var instance = (try? DAO.load()) ?? DAO()
    
    var fonts: [Typographie] = []
    
    private init() {}
    
    func createNewFont(name: String) {
        var newFont = Typographie(name: name, characters: [])
        
        let uppercaseAlphabet: [String] = (65...90).map { String(UnicodeScalar($0)!) }
        
        for caractere in uppercaseAlphabet {
            let character = Caractere(letra: caractere, image: nil, grid: nil)
            newFont.characters.append(character)
        }
        
        self.fonts.append(newFont)
    }
    
    func atribuiGrid(fontIndex: Int, characterIndex: Int, grid: [[Int]]) {
        self.fonts[fontIndex].characters[characterIndex].grid = grid
    }
    
    func atribuiImage(fontIndex: Int, characterIndex: Int, image: Data) {
        self.fonts[fontIndex].characters[characterIndex].image = image
    }
    
    func deleteFont() {
        // deletar a fonte
    }
    
    // Função para criar o JSON com nome da fonte
    func createJSON(fontName: String, index: Int) -> Data? {
        // Estrutura para armazenar os dados conforme JSON esperado pela API
        struct APIData: Codable {
            var font_name: String  // Nome da fonte a ser gerada
            var letters: [String: [[Int]]]  // Dicionário de letras e seus grids
        }
        
        // Array para armazenar os dados dos caracteres
        var lettersData = [String: [[Int]]]()
        
        // Preenche o dicionário lettersData com as letras e seus respectivos grids
        for caractere in self.fonts[index].characters {
            if let grid = caractere.grid {
                lettersData[caractere.letra] = grid
            }
        }
        
        // Cria a estrutura APIData com o nome da fonte e os grids das letras
        let apiData = APIData(font_name: fontName, letters: lettersData)
        
        // Cria um JSON a partir dos dados estruturados
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted  // Para formato legível
        
        do {
            let jsonData = try encoder.encode(apiData)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                if let response = requestPOST(json: jsonString) {
                    saveTTFFromData(data: response, fontName: fontName)
                    return response
                }
            }
        } catch {
            print("Error encoding JSON: \(error)")
        }
        
        return nil  // Retorna nil se houver algum erro
    }
    
    // Função para fazer o request POST
    func requestPOST(json: String) -> Data? {
        
        // API_MV is in a secret file, ignored by git
        guard let apiUrl = URL(string: API_MV) else {
            print("URL inválida: \(url)")
            return nil
        }
        
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = json.data(using: .utf8)
        
        do {
            let responseData = try NSURLConnection.sendSynchronousRequest(request, returning: nil)
            return responseData
        } catch {
            print("Erro na requisição POST: \(error)")
            return nil
        }
    }
    
    func saveTTFFromData(data: Data, fontName: String) {
        // Save the received .ttf file to the device's file system
        // For example, you can save it in the Documents directory
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentsDirectory.appendingPathComponent("\(fontName).ttf")
            do {
                try data.write(to: fileURL)
                print("TTF file saved successfully.")
                print(fileURL)
            } catch {
                print("Error saving TTF file: \(error)")
            }
        }
    }
}
