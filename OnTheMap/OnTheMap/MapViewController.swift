//
//  ViewController.swift
//  OnTheMap
//
//  Created by Rachel Schifano on 12/31/15.
//  Copyright © 2015 schifano. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getStudentLocationsForMap()

    }
    
    func getStudentLocationsForMap() {
        // Retrieve student locations
        ParseClient.sharedInstance().getMapStudentLocations() { locations, error in
            if let locations = locations {
                dispatch_async(dispatch_get_main_queue()) {
                    UdacityClient.StudentInformation.locations = locations
                    self.mapView.reloadInputViews()
                    self.addLocationsToMapView()
                }
            }
        }
    }
    
    func addLocationsToMapView() {
        var annotations = [MKPointAnnotation]()
        
        for location in UdacityClient.StudentInformation.locations {
            
            let lat = CLLocationDegrees(location.latitude as Float)
            let long = CLLocationDegrees(location.longitude as Float)
            
            // The lat and long are used to create a CLLocationCoordinates2D instance.
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let first = location.firstName! as String
            let last = location.lastName! as String
            let mediaURL = location.mediaURL! as String
            
            // Here we create the annotation and set its coordiate, title, and subtitle properties
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            
            // Finally we place the annotation in an array of annotations.
            annotations.append(annotation)
            
        }
        
        // When the array is complete, we add the annotations to the map.
        mapView.addAnnotations(annotations)
    }

    /**
     Returns the view associated with the specified annotation object.
     - parameter mapView: The map view that requested the annotation view.
     - parameter annotation: The object representing the annotation that is about to be displayed.
     - returns: The annotation view to display for the specified annotation or nil to disaply a standard annotation view.
    */
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseID = "pin"
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseID) as? MKPinAnnotationView
        
        if pinView == nil {
            // create pin
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = UIColor.redColor()
            pinView!.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        } else {
            pinView!.annotation = annotation
        }
        return pinView
    }
    
    /**
     Tells the delegate that the user tapped one of the annotation view's accessory buttons.
     - parameter mapView: The map view containing the specified annotation view.
     - parameter view: The annotation view whose button was tapped.
     - parameter control: The control that was tapped.
     */
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.sharedApplication()
            if let toOpen = view.annotation?.subtitle! {
                app.openURL(NSURL(string: toOpen)!)
            }
        }
    }
}