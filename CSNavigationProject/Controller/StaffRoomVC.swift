//
//  StaffRoomVC.swift
//  CSNavigationProject
//
//  Created by Matthew Soh on 9/4/23.
//

import UIKit
import MapKit

class StaffRoomVC: UIViewController, MKMapViewDelegate {
    var chosenStaffRoom = "Art"
    var currentStaffRoom = "Art"
    
    @IBOutlet weak var mapView: MKMapView!

    var currentLocationChanged = false
    var destinationStaffRoom: Location!
    var currentLocation: Location!
    var locationsArray: [[String: Any]]!
    
    let regionDistance: CLLocationDegrees = 100.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let path = Bundle.main.path(forResource: "ClassroomStaffInfo", ofType: "plist"), let arr = NSArray(contentsOfFile: path) as? [[String: Any]] {
            locationsArray = arr
        } else {
            print("Error downloading school data.")
        }
        print(locationsArray!)
        setupClassroomInformation()
        setupMapView()
        updateMap()
    }
    
    func setupMapView() {
        let destinationRegion = MKCoordinateRegion(center: destinationStaffRoom.coordinate, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        mapView.setRegion(destinationRegion, animated: true)
    }
    
    func setupClassroomInformation() {
        for loc in locationsArray {
            let name = loc["Name"] as! String
            if name.contains(chosenStaffRoom) {
                let type = loc["Type"] as? String
                let latitude = Double(loc["Latitude"] as! String)!
                let longitude = Double(loc["Longitude"] as! String)!
                destinationStaffRoom = Location(name: name, type: type!, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
            } else if name.contains(currentStaffRoom) {
                let type = loc["Type"] as? String
                let latitude = Double(loc["Latitude"] as! String)!
                let longitude = Double(loc["Longitude"] as! String)!
                currentLocation = Location(name: name, type: type!, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
            }
        }
    }
    
    func updateMap() {
//        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(destinationStaffRoom)
        if currentLocationChanged {
            mapView.addAnnotation(currentLocation)
            let centerCoordinateLatitude = (destinationStaffRoom.coordinate.latitude + currentLocation.coordinate.latitude) / 2
            let centerCoordinateLongitude = (destinationStaffRoom.coordinate.longitude + currentLocation.coordinate.longitude) / 2
            
            mapView.setCenter(CLLocationCoordinate2D(latitude: centerCoordinateLatitude, longitude: centerCoordinateLongitude), animated: true)
            print(centerCoordinateLatitude)
            print(centerCoordinateLongitude)
        }else {
            mapView.setCenter(destinationStaffRoom.coordinate, animated: true)
        }
    }
    
    @IBAction func unwindSegue(_ sender: UIButton) {
        if currentLocationChanged {
            performSegue(withIdentifier: "unwindToStaffRoomCurrentLocation", sender: self)
        } else {
            performSegue(withIdentifier: "unwindToVCStaffRoomDestinationPick", sender: self)
        }
    }
//    @IBAction func unwindSegue(_ sender: UIButton) {
//        if currentLocationChanged {
//            performSegue(withIdentifier: "unwindToVCStaffRoomCurrentLocation", sender: self)
//        } else {
//            performSegue(withIdentifier: "unwindToVCStaffRoomDestinationPick", sender: self)
//        }
//    }
}
