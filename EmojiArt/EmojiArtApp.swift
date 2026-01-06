//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by Xavier Pedrals Camprubí on 2/1/26.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    
    @StateObject var defaultDocument = EmojiArtDocument()
    
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: defaultDocument)
            
        }
    }
}
