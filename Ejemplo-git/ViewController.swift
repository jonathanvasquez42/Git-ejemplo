//
//  ViewController.swift
//  Ejemplo-git
//
//  Created by Jonathan on 04-10-15.
//  Copyright (c) 2015 inacap. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var myLocationView: UILabel!
    @IBOutlet weak var myAddresView: UILabel!
    @IBOutlet weak var map: MKMapView!
    var locationManager:CLLocationManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        /*
            var centerLocation = CLLocationCoordinate2DMake(-39.8130813, -73.2464813)
            var mapSpan = MKCoordinateSpanMake(0.01,0.01 )
            var MapRegion = MKCoordinateRegionMake(centerLocation, mapSpan)
            self.map.setRegion(MapRegion, animated: true)
        
            var annotation = MKPointAnnotation()
        
            annotation.coordinate = centerLocation
            annotation.title = "Camino al casino ..."
            map.addAnnotation(annotation)
        
            self.map.addAnnotation(annotation)
*/
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
       let regionToZoom = MKCoordinateRegionMake(manager.location.coordinate, MKCoordinateSpanMake(0.05,0.05 ))
        map.setRegion(regionToZoom, animated: true)
        myLocationView.text = "\(locationManager.location)"

        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: { (placemark , error) -> Void in
            
            if error != nil {
                println("Error")
                return
            }
            if placemark.count > 0 {
                let pn = placemark[0] as! CLPlacemark
                self.displayLocationInfo(pn)
                
                
            }
            }
        
        )}

    
    func displayLocationInfo(placemark: CLPlacemark){
        myAddresView.text = "\(placemark.subThoroughfare)\(placemark.thoroughfare)\(placemark.subLocality)\(placemark.locality)\(placemark.administrativeArea)\(placemark.postalCode)\(placemark.country)"
      
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError Error: NSError! ) {
        
        println("ERROR")
        
    }

}
