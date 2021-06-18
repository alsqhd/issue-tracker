//
//  User.swift
//  IssueTracker
//
//  Created by 지북 on 2021/06/09.
//

import Foundation

protocol Filterable {
    var id: Int { get }
    var name: String { get }
}

struct User: Filterable {
    var id: Int
    var name: String
    var imageURL: String?
}
