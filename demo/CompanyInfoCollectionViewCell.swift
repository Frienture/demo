//
//  CompanyInfoCollectionViewCell.swift
//  demo
//
//  Created by macbookpro on 07/03/2022.
//

import UIKit

class CompanyInfoCollectionViewCell: UICollectionViewCell {
    static let identifier = "CompanyInfoCollectionViewCell"
    
    weak var viewController: UIViewController?
    
    private var companyImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .bold)
        label.text = "Location:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.text = "Donver Street"
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        return label
    }()
 
    private let stationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stationNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let openingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let detailText : UILabel = {
        let text = UILabel()
        text.numberOfLines = 0
        text.lineBreakMode = .byWordWrapping
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(companyImage)
        contentView.addSubview(stationLabel)
        contentView.addSubview(stationNameLabel)
        contentView.addSubview(addressLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(openingLabel)
        contentView.addSubview(detailText)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        locationLabel.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                               action: #selector(openMapTapped)))
        setupLayout()
        
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            companyImage.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            companyImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            companyImage.heightAnchor.constraint(equalToConstant: 300),
            stationLabel.topAnchor.constraint(equalTo: companyImage.bottomAnchor,
                                              constant: 10),
            stationLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                               constant: 10),

            stationNameLabel.bottomAnchor.constraint(equalTo: stationLabel.bottomAnchor),
            stationNameLabel.leftAnchor.constraint(equalTo: stationLabel.rightAnchor,
                                                   constant: 10),

            addressLabel.topAnchor.constraint(equalTo: stationLabel.bottomAnchor,
                                              constant: 10),
            addressLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                               constant: 10),

            locationLabel.bottomAnchor.constraint(equalTo: addressLabel.bottomAnchor),
            locationLabel.leftAnchor.constraint(equalTo: addressLabel.rightAnchor,
                                                constant: 10),

            openingLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor,
                                              constant: 10),
            openingLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                               constant: 10),

            timeLabel.topAnchor.constraint(equalTo: openingLabel.bottomAnchor),
            timeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                            constant: 10),
            timeLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                             constant: -10),

            detailText.topAnchor.constraint(equalTo: timeLabel.bottomAnchor,
                                            constant: 30),
            detailText.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                             constant: 10),
            detailText.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                              constant: -10)
            
        ])
    }
    
    @objc private func openMapTapped(){
        openMaps()
    }
    
     func openMaps() {
        let application = UIApplication.shared
        let latitude = 45.5088
        let longitude = -73.554
        let coordinate = "\(latitude),\(longitude)"
         let encodedTitle = locationLabel.text?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let handlers = [
            ("Apple Maps", "http://maps.apple.com/?q=\(encodedTitle)&ll=\(coordinate)"),
            ("Google Maps", "comgooglemaps://?q=\(coordinate)"),
            ("Waze", "waze://?ll=\(coordinate)"),
            ("Citymapper", "citymapper://directions?endcoord=\(coordinate)&endname=\(encodedTitle)")
        ]

            .compactMap { (name, address) in URL(string: address).map { (name, $0) } }
            .filter { (_, url) in application.canOpenURL(url) }
//        guard handlers.count > 1 else {
//            if let (_, url) = handlers.first {
//                application.open(url, options: [:])
//            }
//            return
//        }
        let alert = UIAlertController(title: "Select Navigation App", message: nil, preferredStyle: .actionSheet)
        handlers.forEach { (name, url) in
            alert.addAction(UIAlertAction(title: name, style: .default) { _ in
                application.open(url, options: [:])
            })
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
         viewController?.present(alert, animated: true, completion: nil)
    }
    
    public func configure() {
        self.companyImage.image = UIImage(named: "escaperoom")
        self.addressLabel.text = "Location:"
        self.locationLabel.text = "Donver Street"
        self.stationLabel.text = "Closest Station:"
        self.stationNameLabel.text = "Somewhere Station"
        self.openingLabel.text = "Opening hours:"
        self.timeLabel.text = "Monday-Wednesday(9am-11pm), Thursday-Saturday(9am-12pm), Sunday(Off)"
        self.detailText.text = "Claiming the record of longest indoor Escape Room. Most fun and exciting experience you even have."
        
    }
}


