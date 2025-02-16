//
//  Scorecard+Stub.swift
//  Twinmoji
//
//  Created by Uri on 16/2/25.
//

import Foundation

#if DEBUG
extension Scorecard {
    static var stub: [Scorecard] {
        [
            Scorecard(player: "Uri", deck: .animals, matches: 10, score: 400),
            Scorecard(player: "Darko", deck: .faces, matches: 8, score: 460),
            Scorecard(player: "Makabre", deck: .flags, matches: 9, score: 400),
            Scorecard(player: "Larry", deck: .food, matches: 10, score: 40),
            Scorecard(player: "Oscar", deck: .animals, matches: 5, score: 400),
            Scorecard(player: "Uri", deck: .faces, matches: 10, score: 4000),
            Scorecard(player: "Darko", deck: .flags, matches: 7, score: 460),
            Scorecard(player: "Makabre", deck: .food, matches: 8, score: 400),
            Scorecard(player: "Lofilldigneeeeeeeeee", deck: .animals, matches: 2, score: 40),
            Scorecard(player: "Oscar", deck: .faces, matches: 3, score: 400)
        ]
    }
}
#endif
