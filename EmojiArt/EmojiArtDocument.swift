import SwiftUI
internal import Combine

class EmojiArtDocument: ObservableObject {
    typealias Emoji = EmojiArt.Emoji
    
    @Published private var emojiArt = EmojiArt() {//model
        didSet { //cada cop que canvia -> autosave
            autosave()
        }
    }
    
    private let autosaveURL: URL = URL.documentsDirectory.appendingPathComponent("Autosaved.emojiart")
    
    private func autosave() {
        save(to: autosaveURL)
        print("autosaved to \(autosaveURL)")
    }
    
    private func save(to url: URL) {
        do {
            let data = try emojiArt.json()
            try data.write(to: url)
        } catch let error {
            print("EmojiArtDocument: error while saving \(error.localizedDescription)")
        }
        
    }
    
    init() { //Carrega dades persistides del disc, Decideix quin estat inicial tindrà el document, Implementa la política de recuperació automàtica (autosave)
        if let data = try? Data(contentsOf: autosaveURL),
           let autosaveEmojiArt = try? EmojiArt(json: data) {
            emojiArt = autosaveEmojiArt
        }
    }
    
    // MARK: -Accés al model
    var emojis: [Emoji] { emojiArt.emojis }
    var background: URL? { emojiArt.background }
    
    //MARK: - Intencions usuari
    func setBackground(_ url: URL?) {
        emojiArt.background = url
    }
    
    func addEmoji(_ emoji: String, at position: Emoji.Position, size: CGFloat) {
        emojiArt.addEmoji(emoji, at: position, size: Int(size))
    }
}

extension EmojiArt.Emoji {
    var font: Font {
        Font.system(size: CGFloat(size))
    }
}

extension EmojiArt.Emoji.Position {
    func `in` (_ geometry: GeometryProxy) -> CGPoint {
        let center = geometry.frame(in: .local).center
        return CGPoint(x: center.x + CGFloat(x), y: center.y - CGFloat(y))
    }
}

