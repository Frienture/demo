//
//  CreateMapViewController.swift
//  demo
//
//  Created by macbookpro on 19/9/2021.
//

import CoreLocation
import UIKit
import MapKit

class CreateMapViewController: UITabBarController {

    private let contentView = UIView()
    
    private let mapView = MKMapView()
    
    private let searchController = UISearchController()
    
    private let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create Group"
        view.backgroundColor = .systemBackground
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(dismissSelf))
        
        navigationItem.searchController = searchController
        
        view.addSubview(mapView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
        manager.startUpdatingLocation()
    }
    
    
    func render(_ location: CLLocation) {
        
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        
        let regino = MKCoordinateRegion(center: coordinate,
                                        span: span)

        mapView.setRegion(regino,
                          animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
    }
    
    @objc private func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }

}

extension CreateMapViewController: CLLocationManagerDelegate, UISearchControllerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation()
            
        render(location)
        }
    }
    
    
}
