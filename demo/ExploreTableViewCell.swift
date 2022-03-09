//
//  ExploreTableViewCell.swift
//  demo
//
//  Created by macbookpro on 16/11/2021.
//

import UIKit

class ExploreTableViewCell: UITableViewCell {
    static let identifier = "ExploreTableViewCell"
    

    
    private let pageControl: UIPageControl = {
        let control = UIPageControl()
        control.currentPage = 0
        control.numberOfPages = 3
        return control
    }()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(imageView)
//        contentView.clipsToBounds = true
    addSubview(pageControl)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = CGRect(x: 0,
                                 y: 0,
                                 width: contentView.width,
                                 height: contentView.height)
//
//        pageControl.frame = CGRect(x: 0,
//                                   y: imageView.height/2 - 20,
//                                 width: width,
//                                 height:height)
        
       
    }
    
    public func configure(with model: cell) {
        self.imageView.image = model.imageURL
        self.pageControl.currentPage = model.pageCount
}
