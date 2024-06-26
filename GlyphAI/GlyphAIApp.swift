//
//  GlyphAIApp.swift
//  GlyphAI
//
//  Created by infra on 18/06/24.
//

import SwiftUI

let dao: DAO = DAO.instance

@main
struct GlyphAIApp: App {
    
    @Environment(\.scenePhase) var scenePhase

    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ApiResponseView(fontName: "Mengo", fontIndex: 0)
//                TutorialTimeToDrawView()
//                YourTypographies()
                    .onChange(of: scenePhase) {
                        switch scenePhase {
                        case .background:
                            do {
                                try DAO.instance.save()
                            } catch {
                                print("Se ferrou")
                            }
                        case .inactive:
                            break
                        case .active:
                            break
                        @unknown default:
                            break
                        }
                    }
            }
        }
    }
}
