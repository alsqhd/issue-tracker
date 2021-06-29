//
//  IssueDetailMockData.swift
//  IssueTracker
//
//  Created by 지북 on 2021/06/28.
//

import Foundation

struct IssueDetailMock {
    static var data: IssueDetail {
        return .init(id: 1, number: 149, title: "[iOS] IssueDetail - 이슈 상세 페이지", createDateTime: "2021-06-28T12:48:22.062Z", author: UserMock.dumba, assignees: [UserMock.dumba, UserMock.lia], labels: [LabelMock.FeatureLabel, LabelMock.iOSLabel], milestone: MilestoneMock.iOSFirstData, mainComment: CommentMock.comment1, comments: [CommentMock.comment2, CommentMock.comment3], closed: false)
    }
}

struct CommentMock {
    static var comment1: Comment {
        return .init(id: 1, author: UserMock.dumba, contents: "이슈 상세 페이지를 기존 `TableView`에서 `CollectionView`로 바꾸고자 합니다.", createDateTime: "2021-06-28T12:48:22.062Z", emojis: [EmojiMock.smile, EmojiMock.eyes, EmojiMock.eyes, EmojiMock.eyes, EmojiMock.eyes])
    }
    
    static var comment2: Comment {
        return .init(id: 2, author: UserMock.lia, contents: "`DiffableDataSouce`를 이용해보시는게 어때요? 의견 부탁드립니다.", createDateTime: "2021-06-28T12:50:22.062Z", emojis: nil)
    }
    
    static var comment3: Comment {
        return .init(id: 3, author: UserMock.dumba, contents: "오 알겠습니다 감사합니다!", createDateTime: "2021-06-28T12:55:22.062Z", emojis: [EmojiMock.smile])
    }
}

struct EmojiMock {
    static var smile: Emoji {
        return Emoji.init(value: "\u{1f600}", count: 1)
    }
    
    static var eyes: Emoji {
        return .init(value: "👀", count: 2)
    }
}
