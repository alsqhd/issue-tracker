//
//  NewIssueViewController.swift
//  IssueTracker
//
//  Created by 지북 on 2021/06/15.
//

import UIKit

class NewIssueViewController: UIViewController, ViewControllerIdentifierable {
    
    static func create(_ viewModel: NewIssueViewModel, _ markdownViewController: MarkdownViewController, _ previewViewController: PreviewViewController) -> NewIssueViewController {
        guard let vc = storyboard.instantiateViewController(identifier: storyboardID) as? NewIssueViewController else {
            return NewIssueViewController()
        }
        vc.viewModel = viewModel
        vc.markdownViewController = markdownViewController
        vc.previewViewController = previewViewController
        return vc
    }
    
    @IBOutlet weak var titleTextFiled: UITextField!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var filteringTableView: UITableView!
    
    private var viewModel: NewIssueViewModel!
    private var markdownViewController: MarkdownViewController?
    private var previewViewController: PreviewViewController?
    private lazy var segmentControl = UISegmentedControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setting()
    }
    
    private func setting() {
        setNavigation()
        setTableView()
    }
    
    private func setNavigation() {
        navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        setSegmentControl()
        navigationItem.titleView = segmentControl
    }
    
    private func setTableView() {
        filteringTableView.backgroundColor = view.backgroundColor
        filteringTableView.setEditing(true, animated: true)
        filteringTableView.allowsMultipleSelectionDuringEditing = true
    }
    
    private func setSegmentControl() {
        let titles = ["Markdown", "Preview"]
        segmentControl = UISegmentedControl(items: titles)
        segmentControl.tintColor = UIColor.white
        segmentControl.backgroundColor = #colorLiteral(red: 0.9332414269, green: 0.9333978295, blue: 0.9375261664, alpha: 1)
        segmentControl.selectedSegmentIndex = 0
        for index in 0...titles.count-1 {
            segmentControl.setWidth(100, forSegmentAt: index)
        }
        segmentControl.sizeToFit()
        segmentControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.sendActions(for: .valueChanged)
    }
    
    @objc func segmentChanged(_ sender: UISegmentedControl) {
        updateView()
    }
}

//MARK: - Segment Action

extension NewIssueViewController {
    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        containerView.addSubview(viewController.view)
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
    private func updateView() {
        guard let previewViewController = previewViewController, let markdownViewController = markdownViewController else { return }
        if segmentControl.selectedSegmentIndex == 0 {
            remove(asChildViewController: previewViewController)
            add(asChildViewController: markdownViewController)
        } else {
            remove(asChildViewController: markdownViewController)
            previewViewController.load(markdownViewController.textView.text)
            add(asChildViewController: previewViewController)
        }
    }
}

extension NewIssueViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.filteringSection.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.filteringSection[section].collapsed {
            return 0
        }
        return viewModel.filteringSection[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        
        content.text = viewModel.filteringSection[section].items[row].name
        cell.contentConfiguration = content
        cell.selectedBackgroundView = UIView()
        
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = FilteringHeader(title: viewModel.filteringSection[section].name)
        button.tag = section
        button.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: view.frame.width - 50, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(handleExpandClose(_:)), for: .touchUpInside)
        
        return button
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        42
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        1
    }
    
    @objc func handleExpandClose(_ sender: UIButton) {
        let section = sender.tag
        var indexPaths = [IndexPath]()
        for row in viewModel.filteringSection[section].items.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        let collapsed = viewModel.filteringSection[section].collapsed
        viewModel.filteringSection[section].collapsed = !collapsed
        
        if !collapsed {
            filteringTableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            filteringTableView.insertRows(at: indexPaths, with: .fade)
            filteringTableView.scrollToRow(at: indexPaths[0], at: .top, animated: true)
        }
        
        UIView.animate(withDuration: 0.2) {
            sender.imageView?.transform = CGAffineTransform(rotationAngle: !collapsed ? 0.0 : .pi / 2)
        }
    }
}

