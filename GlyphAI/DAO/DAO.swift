//
//  DAO.swift
//  GlyphAI
//
//  Created by infra on 21/06/24.
//

import Foundation
import CodableExtensions

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
    
    // Função que faz o request para a api passando todas as imagens dos caracteres
    func uploadCharacters(characters: [Caractere]) {
        guard let url = URL(string: "http://127.0.0.1:5000/upload") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        
        for character in characters {
            if let imageData = character.image {
                let filename = "\(character.letra).png"
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"files\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
                body.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
                body.append(imageData)
                body.append("\r\n".data(using: .utf8)!)
            }
        }
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Status code: \(response.statusCode)")
            }
            
            if let data = data {
                print("Response data: \(String(data: data, encoding: .utf8) ?? "")")
            }
        }.resume()
    }
}
