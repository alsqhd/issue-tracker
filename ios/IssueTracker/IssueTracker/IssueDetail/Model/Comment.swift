//
//  Comment.swift
//  IssueTracker
//
//  Created by 지북 on 2021/06/22.
//

import Foundation

struct Comment: Decodable {
    let id: Int
    let author: User
    let contents: String
    let createDateTime: String
    let emojis: [Emoji]?
}
