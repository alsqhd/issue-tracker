//
//  Issue.swift
//  IssueTracker
//
//  Created by 지북 on 2021/06/09.
//

import Foundation

struct Issue: Codable {
    var id: Int
    var number: Int
    var title: String
    var description: String
    var hasSameAuthorComments: Bool
    var createDateTime: String
    var closed: Bool
    var author: User
    var assignees: [User]?
    var labels: [Label]?
    var milestone: Milestone?
}
