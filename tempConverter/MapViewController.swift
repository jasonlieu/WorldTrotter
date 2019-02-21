//
//  MapViewController.swift
//  tempConverter
//
//  Created by Jason Lieu on 2/6/19.
//  Copyright © 2019 JasonApplication. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var start:Bool = true
    var pins = [MKPointAnnotation]()
    var currentPinPosition = 0
    override func loadView() {
        // Create a map view
        mapView = MKMapView()
        view = mapView
        let segmentedControl
            = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor
            = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self,
            action: #selector(MapViewController.mapTypeChanged(_:)),
            for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        let button = UIButton(frame: CGRect(x: 220, y: 580, width: 150, height: 40))
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Next Location", for: .normal)
        button.addTarget(self, action: #selector(cycleButton), for: .touchUpInside)
        view.addSubview(button)
        
        let topConstraint =
            segmentedControl.topAnchor.constraint(equalTo:topLayoutGuide.bottomAnchor,
                constant: 8)
        let margins = view.layoutMarginsGuide
        let leadingConstraint =
            segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint =
            segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
    }
    @objc func cycleButton(){
        currentPinPosition = (currentPinPosition + 1)%3
        let center = CLLocationCoordinate2D(latitude: pins[currentPinPosition].coordinate.latitude, longitude: pins[currentPinPosition].coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
    }
    @objc func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let currentLocation:CLLocationCoordinate2D =  manager.location!.coordinate
        let currentPin = MKPointAnnotation()
        currentPin.coordinate = CLLocationCoordinate2D(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
        mapView.addAnnotation(currentPin)
        if start{
            pins.append(currentPin)
            let center = CLLocationCoordinate2D(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            mapView.setRegion(region, animated: true)
            start = false
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.stopUpdatingLocation()
        //print("MapViewController loaded its view.")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
        }
        let saigonPin = MKPointAnnotation()
        saigonPin.coordinate = CLLocationCoordinate2D(latitude: 10.8231, longitude: 106.6297)
        mapView.addAnnotation(saigonPin)
        pins.append(saigonPin)
        let disneyPin = MKPointAnnotation()
        disneyPin.coordinate = CLLocationCoordinate2D(latitude: 33.8121 , longitude: -117.9190)
        mapView.addAnnotation(disneyPin)
        pins.append(disneyPin)
    }
    
}
