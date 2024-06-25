//
//  AuxView.swift
//  GlyphAI
//
//  Created by infra on 25/06/24.
//

import SwiftUI

struct AuxView: View {
    
    let index: Int
    
    var body: some View {
        if dao.fonts[index].didGenerate {
            CharactersView(index: index)
        } else {
            ContentView(index: index)
        }
    }
}

#Preview {
    AuxView(index: 1)
}
