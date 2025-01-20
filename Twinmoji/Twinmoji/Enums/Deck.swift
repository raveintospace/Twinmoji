//
//  Deck.swift
//  Twinmoji
//
//  Created by Uri on 20/1/25.
//

enum Deck: String, CaseIterable {
    case animals = "Animals"
    case faces = "Faces"
    case flags = "Flags"
    case food = "Food"

    var emojis: [String] {
        switch self {
        case .animals:
            return Array("🐶🐱🐭🐹🐰🦊🐻🐼🐨🐯🦁🐮🐷🐸🐵🐧🐦🦆🦅🦉🐴🦄🐢🐍🐙🦈🐳🐋🦓🦒🦔🦥🦩").map(String.init)
        case .faces:
            return Array("😎🥹🥰😔😂😳🧐🙂😇😅😆😙😬🙃😍🥸😣😶🙄🤨😩😉🥲😋😛🤓😏😭😯😵😐😘😢😠").map(String.init)
        case .flags:
            return Array("🇦🇩🇦🇷🇦🇺🇧🇷🇨🇦🇨🇳🇫🇷🇩🇪🇮🇳🇮🇹🇯🇵🇲🇽🇳🇱🇳🇴🇵🇭🇵🇱🇷🇺🇪🇸🇰🇷🇸🇪🇬🇧🇺🇸🇿🇦🇪🇺🇮🇪🇧🇪🇨🇴🇨🇱🇪🇨🇬🇷🇩🇰🇮🇱🇱🇺").map(String.init)
        case .food:
            return Array("🍎🍊🍋🍉🍇🍓🍒🍍🥭🍌🍑🥝🥥🍅🍆🥕🥒🌽🥔🍠🍿🥐🥖🥨🥯🍞🥞🧇🧀🥩🍗🍖🥓").map(String.init)
        }
    }
}
