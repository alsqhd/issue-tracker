//
//  PreviewViewController.swift
//  IssueTracker
//
//  Created by 지북 on 2021/06/18.
//

import UIKit
import MarkdownView

final class PreviewViewController: UIViewController, ViewControllerIdentifierable {
    
    static func create() -> PreviewViewController {
        guard let vc = storyboard.instantiateViewController(identifier: storyboardID) as? PreviewViewController else {
            return PreviewViewController()
        }
        return vc
    }
    
    @IBOutlet private weak var markdownView: MarkdownView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func load(_ text: String) {
            markdownView.subviews.forEach { view in
                view.removeFromSuperview()
            }
            markdownView.load(markdown: text, enableImage: true)
        }
    
}
