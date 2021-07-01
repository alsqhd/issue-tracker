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
        setTabBarUI()
        fillUI()
    }
    
}


extension MyAccountViewController {
    
    private func setTabBarUI() {
        let userImageURL = viewModel.user?.profileImage
        
        tabBarItem.title = "Profile"
        tabBarItem.image = userImageURL?.loadImage()
        tabBarItem.imageInsets = UIEdgeInsets(top: 110, left: 110, bottom: 110, right: 110)
    }
    
    private func fillUI() {
        guard let user = viewModel.user else { return }
        let userImageURL = viewModel.user?.profileImage
        
        self.nameLabel.text = user.name
        self.emailLabel.text = user.email
        self.profileImageView.image = userImageURL?.loadImage()
    }
    
    @IBAction func logoutButtonTouched(_ sender: UIButton) {
        viewModel.logout()
    }
    
}
