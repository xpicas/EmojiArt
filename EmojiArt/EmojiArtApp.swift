//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by Xavier Pedrals Camprubí on 2/1/26.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    
    var body: some Scene {
        DocumentGroup(newDocument: {EmojiArtDocument() }) { config in
            EmojiArtDocumentView(document: config.document)            
        }
    }
}
