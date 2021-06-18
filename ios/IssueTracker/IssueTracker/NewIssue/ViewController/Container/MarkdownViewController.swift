//
//  MarkdownViewController.swift
//  IssueTracker
//
//  Created by 지북 on 2021/06/17.
//

import UIKit

class MarkdownViewController: UIViewController, ViewControllerIdentifierable {

    static func create(_ viewModel: NewIssueViewModel) -> MarkdownViewController {
        guard let vc = storyboard.instantiateViewController(identifier: storyboardID) as? MarkdownViewController else {
            return MarkdownViewController()
        }
        vc.viewModel = viewModel
        return vc
    }

    @IBOutlet weak var textView: UITextView!
    private var viewModel: NewIssueViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
