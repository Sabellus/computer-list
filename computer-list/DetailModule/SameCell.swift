//
//  SameCell.swift
//  computer-list
//
//  Created by Савелий Вепрев on 09.02.2020.
//  Copyright © 2020 Савелий Вепрев. All rights reserved.
//

import Foundation

import UIKit

class SameCell: UITableViewCell {
    
    var linkItemText: String? {
        didSet {
            if let text = linkItemText {
                leftLabel.text = text
            }
        }
    }
    
    private let leftLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.textColor = #colorLiteral(red: 0.368627451, green: 0.3725490196, blue: 0.3803921569, alpha: 1)
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 24)
        label.attributedText = NSAttributedString(string: "Text", attributes:
        [.underlineStyle: NSUnderlineStyle.single.rawValue])
        return label
    }()
    
    private let rightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "more")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
            
        contentView.addSubview(leftLabel)
        contentView.addSubview(rightImageView)

         NSLayoutConstraint.activate([
            leftLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            leftLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        
            rightImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            rightImageView.widthAnchor.constraint(equalToConstant: 30),
            rightImageView.heightAnchor.constraint(equalToConstant: 7),
            rightImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
         ])
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
