//
//  GroupInfoViewController.swift
//  demo
//
//  Created by macbookpro on 27/9/2021.
//

import UIKit

class GroupInfoViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        scrollView.isScrollEnabled = true
        return scrollView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        joinButton.addTarget(self,
                         action: #selector(joinButtonTapped),
                         for: .touchUpInside)
        
        //Add subview
        view.addSubview(scrollView)
        scrollView.addSubview(companynameLabel)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(joinButton)
        scrollView.addSubview(dateLabel)
        scrollView.addSubview(timeLabel)
        scrollView.addSubview(locationLabel)
        scrollView.addSubview(imageView)
        scrollView.addSubview(companyImage)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        companynameLabel.frame = CGRect(x: 50, y: 20, width: 300, height: 50)
        companyImage.frame = CGRect(x: 0, y: companynameLabel.bottom + 20, width: view.width, height: 300)
        nameLabel.frame = CGRect(x: 100, y: companyImage.bottom + 35, width: 200, height: 50)
        locationLabel.frame = CGRect(x: 100, y: nameLabel.bottom + 20, width: 250, height: 50)
        timeLabel.frame = CGRect(x: 5, y: locationLabel.bottom + 20, width: 200, height: 50)
        dateLabel.frame = CGRect(x: timeLabel.right, y: locationLabel.bottom + 20, width: 200, height: 50)
        imageView.frame = CGRect(x: 0, y: dateLabel.bottom + 10, width: view.width, height: 300)
        joinButton.frame = CGRect(x: scrollView.width/2-100, y:  imageView.bottom + 50 , width: 200, height: 50)
        
        scrollView.contentSize = CGSize(width: view.width, height: joinButton.bottom + 20)
    }
    
    private let companynameLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 13
        label.font = .systemFont(ofSize: 21, weight: .bold)
        label.text = "Tennis Club Ltd."
        label.layer.masksToBounds = true
        label.textAlignment = .center
        
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 13
        label.font = .systemFont(ofSize: 21, weight: .bold)
        label.text = "Date: 12, Oct, 2021"
        label.layer.masksToBounds = true
        label.textAlignment = .center
        
        return label
    }()
    
    private var companyImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "tennis")
        return imageView
    }()
   
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "map")
        return imageView
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 13
        label.font = .systemFont(ofSize: 21, weight: .bold)
        label.text = "Time 13:00"
        label.layer.masksToBounds = true
        label.textAlignment = .center
        
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 13
        label.font = .systemFont(ofSize: 21, weight: .bold)
        label.text = "Location: Donver Street"
        label.layer.masksToBounds = true
        label.textAlignment = .center
        
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 13
        label.font = .systemFont(ofSize: 21, weight: .bold)
        label.text = "Name: Tennis"
        label.layer.masksToBounds = true
        label.textAlignment = .center
        
        return label
    }()
    
    private let joinButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .secondarySystemBackground
        button.setTitle("Join", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 21, weight: .bold)
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        
        return button
    }()
    
    @objc private func joinButtonTapped() {
        print("Joined")
        navigationController?.popViewController(animated: true)
    }


}
