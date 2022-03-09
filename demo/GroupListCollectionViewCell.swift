//
//  GroupListCollectionViewCell.swift
//  demo
//
//  Created by macbookpro on 6/10/2021.
//

import UIKit

class GroupListCollectionViewCell: UICollectionViewCell {
    static let identifier = "GroupListCollectionViewCell"
    let date = CreateViewController.datePickerFormatter.string(from:Date())
    let time = CreateViewController.timePickerFormatter.string(from:Date())
    
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
    
    private let groupLimitLabel: UILabel = {
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
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
   
    private let timeLabel: UILabel = {
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
        contentView.addSubview(groupLimitLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(timeLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.sizeToFit()
        groupNameLabel.sizeToFit()
        locationLabel.sizeToFit()
        dateLabel.sizeToFit()
        timeLabel.sizeToFit()
        groupLimitLabel.sizeToFit()
        
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
        
        dateLabel.frame = CGRect(x: timeLabel.right + 20 ,
                                    y: locationLabel.bottom + 5,
                                     width: dateLabel.width,
                                      height: dateLabel.height)
        
        timeLabel.frame = CGRect(x: 5,
                                     y: locationLabel.bottom + 5,
                                     width: timeLabel.width ,
                                      height: timeLabel.height)
        
        groupLimitLabel.frame = CGRect(x: 10,
                                       y: timeLabel.bottom + 5,
                                       width: groupLimitLabel.width,
                                       height: groupLimitLabel.height)
    }
    
    public func configure(with model: GroupInfo) {
        self.groupNameLabel.text = model.name
        self.locationLabel.text = "Location: "
        self.dateLabel.text = "Date: \(date)"
        self.groupLimitLabel.text = "_ /\(model.max)"
        self.timeLabel.text = "Time: \(time)"
        
    }
}
