//
//  IssueCell.swift
//  IssueTracker
//
//  Created by Lia on 2021/06/08.
//

import UIKit

class IssueCell: UITableViewCell, ReuseIdentifierable, UINibCreatable {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var milestoneView: UIView!
    @IBOutlet private weak var milestoneLabel: UILabel!
    @IBOutlet private weak var labelStackView: UIStackView!
    
}


extension IssueCell {
    
    func fillUI(with issue: Issue) {
        titleLabel.text = issue.title
        descriptionLabel.text = issue.description
        descriptionLabel.addLineSpacing()
        configureMilestone(with: issue.milestone)
        fillLabels(with: issue.labels ?? [])
    }
    
    private func fillLabels(with labels: [Label]) {
        labelStackView.arrangedSubviews.forEach { label in
            label.removeFromSuperview()
        }
        labels.forEach { label in
            let label_ = LabelView()
            label_.fillUI(with: label)
            self.labelStackView.addArrangedSubview(label_)
        }
    }
    
    private func configureMilestone(with milestone: Milestone?) {
        if let milestone = milestone {
            milestoneView.isHidden = false
            milestoneLabel.text = milestone.name
        } else {
            milestoneView.isHidden = true
            NSLayoutConstraint.activate([
                milestoneView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0)
            ])
        }
    }
    
}
