//
//  CommentCell.swift
//  IssueTracker
//
//  Created by 지북 on 2021/06/22.
//

import UIKit
import MarkdownView

class CommentCell: UITableViewCell, UINibCreatable, DateManagable {

    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var elapsedTimeLabel: UILabel!
    @IBOutlet private weak var commentView: MarkdownView!
    @IBOutlet private weak var emojiStackView: UIStackView!
    
    func fillUI(_ comment: Comment) {
        profileImageView.load(url: comment.author.profileImage)
        userNameLabel.text = comment.author.name
        elapsedTimeLabel.text = intervalTime(historyTime: comment.createDateTime)
        commentView.load(markdown: comment.contents)
        fillEmojis(comment.emojis)
    }
    
    private func fillEmojis(_ emojis: [Emoji]?) {
        emojiStackView.arrangedSubviews.forEach { label in
            label.removeFromSuperview()
        }
        
        emojis?.forEach({[weak self] emoji in
            let emojiLabel = EmojiLabel()
            emojiLabel.fillUI(emoji)
            self?.emojiStackView.addArrangedSubview(emojiLabel)
        })
    }
    
}
