//
//  ViewController.swift
//  MyMap2
//
//  Created by hayatosann on 2019/09/10.
//  Copyright © 2019 hayatosann. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController,UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        inputText.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        let searchKeyword = textField.text
        
        print(searchKeyword!)
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(searchKeyword!, completionHandler: { (placemarks:[CLPlacemark]?,error:Error?) in
            
            if let placemark = placemarks?[0]{
                if let targetCoordinate = placemark.location?.coordinate{
                    print(targetCoordinate)
                    
                    let pin = MKPointAnnotation()
                    pin.coordinate = targetCoordinate
                    pin.title = searchKeyword
                    
                    self.displayMap.addAnnotation(pin)
                    self.displayMap.region =
                        MKCoordinateRegion(center: targetCoordinate,latitudinalMeters: 500.0,longitudinalMeters: 500.0)
                }
            }
        })
        return true
    }

    @IBOutlet weak var inputText: UITextField!
    
    @IBOutlet weak var displayMap: MKMapView!
}

