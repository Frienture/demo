//
//  TypeCollectionViewCell.swift
//  demo
//
//  Created by macbookpro on 6/10/2021.
//

import UIKit

class TypeCollectionViewCell: UICollectionViewCell {
    static let identifier = "TypeCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let groupNameLabel: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 21, weight: .bold)
        lable.numberOfLines = 0
        lable.textAlignment = .center
        return lable
    } ()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(groupNameLabel)
        contentView.addSubview(imageView)
        contentView.clipsToBounds = true
        contentView.backgroundColor = .secondarySystemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        groupNameLabel.sizeToFit()
        let imageSize = contentView.height
        imageView.frame = CGRect(x: 0,
                                 y: 0,
                                 width: imageSize,
                                 height: imageSize)
        imageView.layer.opacity = 0.25
    
        groupNameLabel.frame = CGRect(x: 0,
                                      y: contentView.height/2-groupNameLabel.height+10 ,
                                      width: contentView.width,
                                      height: groupNameLabel.height)
        
        
       
    }
    
    public func configure(with model: TypeCollectionViewCellModel) {
        self.groupNameLabel.text = model.name
        self.imageView.image = model.imageURL
        
        
    }
}



