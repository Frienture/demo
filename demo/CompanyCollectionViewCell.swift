//
//  CompanyCollectionViewCell.swift
//  demo
//
//  Created by macbookpro on 19/11/2021.
//

import UIKit

class CompanyCollectionViewCell: UICollectionViewCell {
    static let identifier = "CompanyCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "tennis-origins")
        return imageView
    }()
    
    private let groupNameLabel: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 21, weight: .semibold)
        lable.numberOfLines = 0
        return lable
    } ()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private let peopleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
   
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private let groupnumberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(imageView)
        contentView.addSubview(groupNameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(peopleLabel)
        contentView.addSubview(scoreLabel)
        contentView.addSubview(groupnumberLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.sizeToFit()
        groupNameLabel.sizeToFit()
        locationLabel.sizeToFit()
        peopleLabel.sizeToFit()
        scoreLabel.sizeToFit()
        priceLabel.sizeToFit()
        groupnumberLabel.sizeToFit()
        
        imageView.frame = CGRect(x: 0,
                                 y: 0,
                                 width: contentView.width,
                                 height: 200)
        
        groupNameLabel.frame = CGRect(x: 5,
                                      y: imageView.bottom + 2,
                                      width: groupNameLabel.width ,
                                      height: 20)
        
        locationLabel.frame = CGRect(x: contentView.right-locationLabel.width-100,
                                     y: imageView.bottom + 5,
                                     width: locationLabel.width,
                                      height: locationLabel.height)
        
        peopleLabel.frame = CGRect(x: scoreLabel.right + 20 ,
                                    y: locationLabel.bottom + 5,
                                     width: peopleLabel.width,
                                      height: peopleLabel.height)
        
        scoreLabel.frame = CGRect(x: 5,
                                     y: locationLabel.bottom + 5,
                                     width: scoreLabel.width ,
                                      height: scoreLabel.height)
        
        priceLabel.frame = CGRect(x: 10,
                                       y: scoreLabel.bottom + 5,
                                       width: priceLabel.width,
                                       height: priceLabel.height)
        groupnumberLabel.frame = CGRect(x: contentView.right-locationLabel.width-100, y: locationLabel.bottom + 20, width: groupnumberLabel.width, height: groupnumberLabel.height)
    }
    
    public func configure(with model: CompanyCellModel) {
        self.imageView.image = UIImage(named: "escaperoom")
        self.groupNameLabel.text = "ESCAP Room"
        self.locationLabel.text = "Location: "
        self.peopleLabel.text = "5-10"
        self.priceLabel.text = "£20-£40"
        self.scoreLabel.text = "4.8(500+)"
        self.groupnumberLabel.text = model.groupnumber
        
        
    }
}

