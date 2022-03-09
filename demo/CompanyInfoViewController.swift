//
//  CompanyInfoViewController.swift
//  demo
//
//  Created by macbookpro on 19/11/2021.
//

import UIKit
import MapKit

class CompanyInfoViewController: UIViewController {
   
    private var collectionViews: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    private let joinButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemOrange
        button.setTitle("Join", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 19, weight: .bold)
        button.setTitleColor(.systemBackground, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 0.5
        button.layer.shadowColor = CGColor(gray: 0.8, alpha: 1)
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let createButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemOrange
        button.setTitle("Create", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 19, weight: .bold)
        button.setTitleColor(.systemBackground, for: .normal)
        button.layer.shadowOpacity = 0.8
        button.layer.shadowRadius = 0.5
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        joinButton.addTarget(self,
                             action: #selector(joinButtonTapped),
                             for: .touchUpInside)
        createButton.addTarget(self,
                               action: #selector(createButtonTapped),
                               for: .touchUpInside)
        //Add subview
        view.addSubview(collectionViews)
        view.addSubview(joinButton)
        view.addSubview(createButton)

        configureCollectionView()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionViews.frame = view.bounds
        collectionViews.backgroundColor = .secondarySystemBackground
        setupLayout()
        
    }
    
    private func configureCollectionView() {
        collectionViews.register(CompanyInfoCollectionViewCell.self, forCellWithReuseIdentifier: CompanyInfoCollectionViewCell.identifier)
        collectionViews.delegate = self
        collectionViews.dataSource = self
    }
  
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            joinButton.topAnchor.constraint(equalTo: view.bottomAnchor,
                                            constant: -150),
            joinButton.leftAnchor.constraint(equalTo: view.leftAnchor,
                                             constant: 20),
            joinButton.widthAnchor.constraint(equalToConstant: 150),
            joinButton.heightAnchor.constraint(equalToConstant: 50),
            
            
            createButton.rightAnchor.constraint(equalTo: view.rightAnchor,
                                                constant: -20),
            createButton.topAnchor.constraint(equalTo: view.bottomAnchor,
                                              constant: -150),
            createButton.widthAnchor.constraint(equalToConstant: 150),
            createButton.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    @objc private func joinButtonTapped() {
        
    }
    @objc private func createButtonTapped() {
        let vc = CreateViewController()
        vc.title = "Created"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CompanyInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CompanyInfoCollectionViewCell.identifier,
            for: indexPath
        ) as? CompanyInfoCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.viewController = self
        cell.configure()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.width, height: view.bottom)
    }
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        joinButton.alpha = 1
        joinButton.isHidden = true
        UIView.animate(withDuration: 0.25) {
            self.joinButton.alpha = 0
        }
        createButton.alpha = 1
        createButton.isHidden = true
        UIView.animate(withDuration: 0.25) {
            self.createButton.alpha = 0
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        joinButton.alpha = 0
        joinButton.isHidden = false
        UIView.animate(withDuration: 0.2) {
            self.joinButton.alpha = 1
        }
        createButton.alpha = 0
        createButton.isHidden = false
        UIView.animate(withDuration: 0.2, delay: 0, options: .transitionFlipFromBottom){
            self.createButton.alpha = 1
        }
        }

    
}
