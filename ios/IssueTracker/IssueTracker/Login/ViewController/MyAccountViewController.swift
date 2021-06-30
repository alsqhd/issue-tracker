//
//  MyAccountViewController.swift
//  IssueTracker
//
//  Created by Lia on 2021/06/25.
//

import UIKit

extension MyAccountViewController: ViewControllerIdentifierable {
    
    static func create(_ viewModel: MyAccountViewModel) -> MyAccountViewController {
        guard let vc = storyboard.instantiateViewController(identifier: storyboardID) as? MyAccountViewController else {
            return MyAccountViewController()
        }
        vc.viewModel = viewModel
        return vc
    }
    
}


class MyAccountViewController: UIViewController {
    
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    
    var viewModel: MyAccountViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        fillUI()
    }
    
}


extension MyAccountViewController {
    
    private func setUI() {
        viewModel.fillUI { [weak self] profileImage, _, _ in
            self?.tabBarItem.title = "Profile"
            self?.tabBarItem.image = profileImage.withRenderingMode(.alwaysOriginal)
            self?.tabBarItem.imageInsets = UIEdgeInsets(top: 110, left: 110, bottom: 110, right: 110)
        }
    }
    
    private func fillUI() {
        viewModel.fillUI { [weak self] profileImage, name, email in
            self?.profileImageView.image = profileImage
            self?.nameLabel.text = name
            self?.emailLabel.text = email
        }
    }
    
    @IBAction func logoutButtonTouched(_ sender: UIButton) {
        viewModel.logout()
    }
    
}
