//
//  FilteringHeader.swift
//  IssueTracker
//
//  Created by 지북 on 2021/06/17.
//

import UIKit

public class FilteringHeader: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(title: String) {
        super.init(frame: .zero)
        configure(title)
    }
    
    private func configure(_ title: String) {
        setTitle(title, for: .normal)
        setTitleColor(.black, for: .normal)
        backgroundColor = .white
        titleLabel?.font = .boldSystemFont(ofSize: 18)
        contentHorizontalAlignment = .leading
        contentVerticalAlignment = .center
        setImage(UIImage(systemName: "chevron.forward"), for: .normal)
        tintColor = .gray
        imageView?.tintColor = .black
    }
}
