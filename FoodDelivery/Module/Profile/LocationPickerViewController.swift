//
//  LocationPickerViewController.swift
//  FoodDelivery
//
//  Created by Alief Ahmad Azies on 23/08/23.
//

import UIKit
import MapKit

class LocationPickerViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager: CLLocationManager!
    
    var location: CLLocation?
    
    var completion: (CLLocationCoordinate2D, String?) -> Void = { (_, _) in }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        setupLocationManager()
    }
    
    func setup() {
        mapView.showsUserLocation = false
        mapView.delegate = self
    }
    
    func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
    func zoomToLocation() {
        if let location = location {
            let coordinatRegion = MKCoordinateRegion(
                center: location.coordinate,
                latitudinalMeters: 2000,
                longitudinalMeters: 2000
            )
            mapView.setRegion(coordinatRegion, animated: true)
            mapView.removeAnnotations(mapView.annotations)
            
            let annotation = FDAnnotation(title: "My Location", subtitle: nil, coordinate: location.coordinate)
            mapView.addAnnotation(annotation)
        }
        
        
    }
}

//MARK: CLLocationManagerDelegate
extension LocationPickerViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.location = location
            zoomToLocation()
            manager.stopUpdatingLocation()
        }
    }
}

extension LocationPickerViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = ""
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        }
        else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        view.canShowCallout = true
        view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if let location = location,
            let annotation = view.annotation as? FDAnnotation {
            
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
                guard let `self` = self else { return }
                let address = placemarks?.first
                
                self.dismiss(animated: true) {
                    self.completion(annotation.coordinate, address?.description)
                }
            }
        }
    }
}

extension UIViewController {
    func presentLocationPickerViewController(completion: @escaping (CLLocationCoordinate2D, String?) -> Void) {
        let viewController = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "LocationPicker") as! LocationPickerViewController
        
        viewController.completion = completion
        
        present(viewController, animated: true, completion: nil)
    }
}
