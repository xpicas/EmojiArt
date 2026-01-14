// View

import SwiftUI

struct PaletteEditor: View {
    @Binding var palette: Palette
    
    @State private var emojisToAdd: String = ""
    
    @FocusState private var focused: Focused?
    
    enum Focused {
        case name
        case addEmojis
    }
    
    private let emojiFont = Font.system(size: 40)
    
    var body: some View {
        Form {
            Section(header: Text("Name")) {
                TextField("Name", text: $palette.name)
                    .focused($focused, equals: .name)
            }
            Section(header: Text("Emojis")) {
                TextField("Add Emojis Here", text: $emojisToAdd)
                    .focused($focused, equals: .addEmojis)
                    .font(emojiFont)
                    .onChange(of: emojisToAdd) {
                        palette.emojis = (emojisToAdd + palette.emojis)
                            .filter { $0.isEmoji }
                            .uniqued
                    }
                removeEmojis
            }
        }
        .frame(minWidth: 300, minHeight: 350)
        .onAppear {
            if palette.name.isEmpty {
                focused = .name
            } else {
                focused = .addEmojis
            }
        }
    }
    
    var removeEmojis: some View {
        VStack(alignment: .trailing) {
            Text ("Tap to Remove Emojis").font(.caption).foregroundColor(.gray)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                ForEach(palette.emojis.uniqued.map(String.init), id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            withAnimation {
                                palette.emojis.removeAll(where: { String($0) == emoji })
                                emojisToAdd.removeAll(where: { String($0) == emoji })
                            }
                        }
                }
            }
        }
        .font(emojiFont)
    }
}




struct PaletteEditor_Previews: PreviewProvider {
    struct Preview: View {
        @State private var palette = PaletteStore(named: "Preview").palettes.first!
        var body: some View {
            PaletteEditor(palette: $palette)
        }
    }
    static var previews: some View {
        Preview()
    }
}
