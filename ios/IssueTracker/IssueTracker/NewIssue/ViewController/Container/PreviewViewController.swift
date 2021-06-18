//
//  PreviewViewController.swift
//  IssueTracker
//
//  Created by 지북 on 2021/06/17.
//

import UIKit

import Combine
import MarkdownView

class PreviewViewController: UIViewController, ViewControllerIdentifierable {

    static func create(_ viewModel: NewIssueViewModel) -> PreviewViewController {
        guard let vc = storyboard.instantiateViewController(identifier: storyboardID) as? PreviewViewController else {
            return PreviewViewController()
        }
        vc.viewModel = viewModel
        return vc
    }

    @IBOutlet weak var markdownView: MarkdownView!
    private var viewModel: NewIssueViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        markdownView.clearsContextBeforeDrawing = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    func load(_ text: String) {
        markdownView.subviews.forEach { view in
            view.removeFromSuperview()
        }
        markdownView.load(markdown: text, enableImage: true)
    }
    
}
