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
            let character = Character(letra: caractere, image: nil, grid: nil)
            newFont.characters.append(character)
        }
        
        self.fonts.append(newFont)
    }
    
    func atribuiGrid(fontIndex: Int, characterIndex: Int, grid: [[Int]]) {
        self.fonts[fontIndex].characters[characterIndex].grid = grid
    }
}
