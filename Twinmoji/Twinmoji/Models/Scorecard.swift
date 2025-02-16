//
//  Scorecard.swift
//  Twinmoji
//
//  Created by Uri on 16/2/25.
//


import Foundation

struct Scorecard: Identifiable, Codable {
    var id = UUID()
    var player: String
    var deck: Deck
    var matches: Int
    var score: Int
}
