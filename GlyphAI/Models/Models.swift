//
//  Models.swift
//  GlyphAI
//
//  Created by infra on 21/06/24.
//

import Foundation
import UIKit

struct Caractere: Codable {
    var letra: String
    var image: Data?
    var grid: [[Int]]?
}

struct Typographie: Codable {
    var name: String
    var characters: [Caractere]
    var didGenerate = false
}
