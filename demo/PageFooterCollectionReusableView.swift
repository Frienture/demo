//
//  PageFooterCollectionReusableView.swift
//  demo
//
//  Created by macbookpro on 06/03/2022.
//

import UIKit

class PageFooterCollectionReusableView: UICollectionReusableView {
        static let identifier = "PageFooterCollectionReusableView"
    
    private let pageControl: UIPageControl = {
        let control = UIPageControl()
        control.currentPage = 0
        control.numberOfPages = 3
        control.currentPageIndicatorTintColor = .darkGray
        control.pageIndicatorTintColor = .lightGray
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
           backgroundColor = .clear

           addSubview(pageControl)

           NSLayoutConstraint.activate([
               pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
               pageControl.centerYAnchor.constraint(equalTo: centerYAnchor)
           ])
       }
    
    func configure(with numberOfPages: Int) {
        pageControl.numberOfPages = numberOfPages
    }
}
