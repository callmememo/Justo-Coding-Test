//
//  UsersCollectionViewCell.swift
//  Coding Test
//
//  Created by Memo on 3/28/21.
//

import UIKit
import SnapKit

class UsersCollectionViewCell: UICollectionViewCell {
    
    private let containerView = UIView()
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    
    var user: User? {
        didSet {
            
            if let user = user {
                
                imageView.kf.setImage(
                    with: URL(string: user.picture.thumbnail),
                    options: [
                        .transition(.fade(0.25)),
                    ]
                )
                
                nameLabel.text = user.fullName
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .clear
        
        contentView.addSubview(containerView)
        
        [imageView,
         nameLabel].forEach { containerView.addSubview($0) }
        
        containerView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalTo(contentView).inset(5)
        }
        
        imageView.snp.makeConstraints {
            $0.centerX.equalTo(containerView)
            $0.top.equalTo(containerView).offset(10)
            $0.height.width.equalTo(70)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(containerView).inset(20)
            $0.top.equalTo(imageView.snp.bottom).offset(10)
            $0.bottom.equalTo(containerView).offset(-10)
        }
        
        containerView.backgroundColor = UIColor.secondarySystemBackground
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
        
        imageView.layer.cornerRadius = 35
        imageView.clipsToBounds = true
        
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        nameLabel.numberOfLines = 0
        nameLabel.lineBreakMode = .byWordWrapping
        nameLabel.textColor = UIColor.secondaryLabel
        nameLabel.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


