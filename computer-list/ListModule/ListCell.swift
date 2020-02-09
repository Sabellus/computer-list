//
//  Listswift
//  computer-list
//
//  Created by Савелий Вепрев on 01.02.2020.
//  Copyright © 2020 Савелий Вепрев. All rights reserved.
//

import Foundation
import UIKit

class ListCell: UITableViewCell {
    
    var nameItemText: String? {
        didSet {
            if let text = nameItemText {
                leftLabel.text = text
            }
        }
    }
    
    var nameCompanyText: String? {
        didSet {
            if let text = nameCompanyText {
                bottomLabel.text = text
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
        return label
    }()
    private let bottomLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 0.7137254902, green: 0.7137254902, blue: 0.7176470588, alpha: 1)
        return label
    }()
    private let rightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "more")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
              
        layer.shadowColor = #colorLiteral(red: 0.9004880016, green: 0.9043430304, blue: 0.9159081169, alpha: 1)
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowOpacity = 1
        layer.shadowRadius = 10
        layer.masksToBounds = false
        layer.cornerRadius = 12
        
        
        contentView.addSubview(leftLabel)
        contentView.addSubview(bottomLabel)
        contentView.addSubview(rightImageView)

         NSLayoutConstraint.activate([
            leftLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            leftLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -8),
            
            bottomLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            bottomLabel.topAnchor.constraint(equalTo: leftLabel.bottomAnchor, constant: 4),
            
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
