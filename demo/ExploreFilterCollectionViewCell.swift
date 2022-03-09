//
//  ExploreFilterCollectionViewCell.swift
//  demo
//
//  Created by macbookpro on 18/11/2021.
//

import UIKit

class ExploreFilterCollectionViewCell: UICollectionViewCell {
    static let identifier = "ExploreFilterCollectionViewCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    let filtenameLabel: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 17, weight: .semibold)
        lable.numberOfLines = 0
        lable.textAlignment = .center
        return lable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        //        contentView.clipsToBounds = true
        addSubview(filtenameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = CGRect(x: contentView.right - 30,
                                 y: 5,
                                 width: 15,
                                 height: 15)
        filtenameLabel.frame = CGRect(x: 10, y: 0, width: 50, height: 30)
        
        
        
    }
    
    public func configure(with model: ExploreFilterCellModel) {
        self.imageView.image = UIImage(named: "arrowdown")
        self.filtenameLabel.text = model.name
        
    }
}



