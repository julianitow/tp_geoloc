//
//  HomeViewController.swift
//  TP_geoloc
//
//  Created by Julien Guillan on 18/11/2020.
//

import UIKit
import MapKit

class HomeViewController: UIViewController {
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var mapView: MKMapView!
    
    var annotations: [MKPointAnnotation] = []
    var stores: [Store] = []
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        self.mapView.addSubview(searchBar)
        
        if CLLocationManager.locationServicesEnabled(){
            let locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            self.locationManager = locationManager
        }
        
        let sws = StoreWebService()
        sws.getStores { (stores) in
            for store in stores {
                self.stores.append(store)
                self.setAnnotations(store: store)
            }
            self.mapView.addAnnotations(self.annotations)
            self.mapView.showAnnotations(self.mapView.annotations, animated: true)
        }
    }
    
    func setAnnotations(store: Store) {
        let annot = MKPointAnnotation()
        annot.title = store.name
        annot.coordinate = CLLocationCoordinate2D(latitude: store.coordinates.coordinate.latitude, longitude: store.coordinates.coordinate.longitude)
        self.annotations.append(annot)
    }
    
    func detailsView(annotation: MKAnnotation) -> UIView? {
        var currentStore: Store!
        guard let title = annotation.title else {
            return nil
        }
        
        let detailsView = UIView()
        let widthConstraint = NSLayoutConstraint(item: detailsView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 130)
        detailsView.addConstraint(widthConstraint)
        
        let heightConstraint = NSLayoutConstraint(item: detailsView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
        detailsView.addConstraint(heightConstraint)
        
        let productTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 21))
        productTitleLabel.text = "Products: "
        detailsView.addSubview(productTitleLabel)
        
        for store in self.stores {
            if store.name == title {
                currentStore = store
            }
        }
        var y = 25
        for product in currentStore.products {
            let nameLabel = UILabel(frame: CGRect(x: 0, y: y, width: 200, height: 21))
            nameLabel.text = product.name
            detailsView.addSubview(nameLabel)
            y += 25
        }

        return detailsView
    }

}

extension HomeViewController: MKMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {

    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "store_annotation")
        if annotationView == nil {
            let newAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "store_annotation")
            let detailsView = self.detailsView(annotation: annotation)
            newAnnotationView.detailCalloutAccessoryView = detailsView
            newAnnotationView.canShowCallout = true
            annotationView = newAnnotationView
        } else {
            annotationView!.annotation = annotation
        }
        return annotationView
    }
}
