//
//  EmojiLabel.swift
//  IssueTracker
//
//  Created by 지북 on 2021/06/29.
//

import UIKit

final class EmojiLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
}


extension EmojiLabel {
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        layer.cornerRadius = 15
        layer.borderWidth = 0.5
        layer.borderColor = #colorLiteral(red: 0.1477919947, green: 0.2647155338, blue: 0.3086573559, alpha: 0.6731289491)
        layer.backgroundColor = #colorLiteral(red: 0.2812377174, green: 0.5037349462, blue: 0.5873531271, alpha: 0.1671324471)
        font = UIFont(descriptor: UIFontDescriptor(name: "System", size: 13), size: 13)
        textAlignment = .center
    }

    func fillUI(_ emoji: Emoji) {
        text = "\(emoji.value) \(String(emoji.count))"
        configureConstraint()
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: intrinsicContentSize.height + 20),
            widthAnchor.constraint(greaterThanOrEqualToConstant: intrinsicContentSize.width + 30)
        ])
    }
    
}

