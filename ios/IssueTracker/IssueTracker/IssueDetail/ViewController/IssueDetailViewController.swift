//
//  IssueDetailViewController.swift
//  IssueTracker
//
//  Created by 지북 on 2021/06/22.
//

import UIKit
import Combine

final class IssueDetailViewController: UIViewController, ViewControllerIdentifierable {
    
    static func create(_ viewModel: IssueDetailViewModel) -> IssueDetailViewController {
        guard let vc = storyboard.instantiateViewController(identifier: storyboardID) as? IssueDetailViewController else {
            return IssueDetailViewController()
        }
        vc.viewModel = viewModel
        return vc
    }
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var stateDescriptionLabel: UILabel!
    @IBOutlet private weak var openStateLabel: OpenCloseLabel!
    @IBOutlet private weak var commentsTableView: UITableView!
    @IBOutlet private weak var newCommentButton: UIButton!
    
    private var viewModel: IssueDetailViewModel!
    private var cancelBag = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setting()
        bind()
    }
    
}

//MARK:- Set Inital Condition

extension IssueDetailViewController {
    
    private func setting() {
        setUI()
        setTableView()
    }
    
    private func setUI() {
        setBackButton()
        setNewCommentButton()
        navigationItem.largeTitleDisplayMode = .never
        commentsTableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func setBackButton() {
        navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped(_:)))
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func setNewCommentButton() {
        newCommentButton.layer.borderWidth = 1
        newCommentButton.layer.borderColor = UIColor.systemGray2.cgColor
        newCommentButton.layer.cornerRadius = 10
        newCommentButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
    }
    
    private func setTableView() {
        commentsTableView.register(CommentCell.nib, forCellReuseIdentifier: CommentCell.reuseIdentifier)
    }
    
    private func bind() {
        viewModel.fetchIssue().receive(on: DispatchQueue.main)
            .sink { [weak self] issue in
                self?.setUI(issue)
                self?.commentsTableView.reloadData()
            }
            .store(in: &cancelBag)
    }
    
    private func setUI(_ issue: IssueDetail) {
        titleLabel.text = issue.title
        stateDescriptionLabel.text = viewModel.stateDescription
        openStateLabel.state(issue.closed)
        numberLabel.text = "#\(issue.number)"
    }
    
    @objc func backButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }
    
}

extension IssueDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1 + (viewModel.issue.comments?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.reuseIdentifier) as? CommentCell else { return UITableViewCell() }
        if indexPath.row == 0 {
            cell.fillUI(viewModel.issue.mainComment)
        } else {
            guard let comment = viewModel.issue.comments?[indexPath.row] else { return UITableViewCell() }
            cell.fillUI(comment)
        }
        return cell
    }
    
    
}

extension IssueDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
