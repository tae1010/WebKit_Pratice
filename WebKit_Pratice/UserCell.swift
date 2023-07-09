//
//  UserCell.swift
//  WebKit_Pratice
//
//  Created by 손인호 on 2023/06/05.
//

import Foundation
import UIKit

class UserCell: UITableViewCell {
    
    let nameTitle = UILabel()
    let emailTitle = UILabel()
    let genderTitle = UILabel()
    
    let name: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let email: UILabel = {
        let label = UILabel()
        label.text = "이메일"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let gender: UILabel = {
        let label = UILabel()
        label.text = "성별"
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension UserCell {
    func setUI() {
        contentView.addSubview(name)
        contentView.addSubview(email)
        contentView.addSubview(gender)
    
        setLayout()
    }
    
    func setLayout() {
        name.translatesAutoresizingMaskIntoConstraints = false
        email.translatesAutoresizingMaskIntoConstraints = false
        gender.translatesAutoresizingMaskIntoConstraints = false
        
        name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        email.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10).isActive = true
        email.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        email.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        gender.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 10).isActive = true
        gender.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        gender.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        gender.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
    
}
