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
    @StateObject var paletteStore = PaletteStore(named: "Main")
    @StateObject var store2 = PaletteStore(named: "Alternate")
    @StateObject var store3 = PaletteStore(named: "Special")
    
    var body: some Scene {
        WindowGroup {
            //PaletteManager(stores: [paletteStore, store2, store3])
            EmojiArtDocumentView(document: defaultDocument)
                .environmentObject(paletteStore)
            
        }
    }
}
