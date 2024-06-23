//
//  Models.swift
//  GlyphAI
//
//  Created by infra on 21/06/24.
//

import Foundation
import UIKit

struct Character: Codable {
    var letra: String
    var image: Data?
    var grid: [[Int]]?
}

struct Typographie: Codable {
    var name: String
    var characters: [Character]
    var didGenerate = false
}
