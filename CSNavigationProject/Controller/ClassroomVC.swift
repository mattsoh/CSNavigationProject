//
//  ClassroomVC.swift
//  CSNavigationProject
//
//  Created by Matthew Soh on 4/2/23.
//
import UIKit
import MapKit

class ClassroomVC: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    var destinationClassroomLocation = "SS1-01"
    var currentClassroomLocation = "SS1-01"
    var currentLocationChanged = false
    var destinationClassroom: Location!
    var currentLocation: Location!
    
    var locationsArray: [[String: Any]]!
    var locations: [Location]!
    
    let regionDistance: CLLocationDegrees = 100.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let path = Bundle.main.path(forResource: "ClassroomStaffInfo", ofType: "plist"), let arr = NSArray(contentsOfFile: path) as? [[String: Any]] {
            locationsArray = arr
        } else {
            print("Error downloading school data.")
        }
    
        setupClassroomInformation()
        setupMapView()
        updateMap()
        print(currentLocationChanged)
    }
    
    func setupMapView() {
        let destinationRegion = MKCoordinateRegion(center: destinationClassroom.coordinate, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        mapView.setRegion(destinationRegion, animated: true)
    }
    
    func setupClassroomInformation() {
        for loc in locationsArray {
            let name = loc["Name"] as! String
            if name.contains(destinationClassroomLocation) {
                let type = loc["Type"] as? String
                let latitude = Double(loc["Latitude"] as! String)!
                let longitude = Double(loc["Longitude"] as! String)!
                destinationClassroom = Location(name: name, type: type!, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
            } else if name.contains(currentClassroomLocation) {
                let type = loc["Type"] as? String
                let latitude = Double(loc["Latitude"] as! String)!
                let longitude = Double(loc["Longitude"] as! String)!
                currentLocation = Location(name: name, type: type!, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
            }
        }    }
    
    func updateMap() {
//        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(destinationClassroom)
        if currentLocationChanged {
            mapView.addAnnotation(currentLocation)
            let centerCoordinateLatitude = (destinationClassroom.coordinate.latitude + currentLocation.coordinate.latitude) / 2
            let centerCoordinateLongitude = (destinationClassroom.coordinate.longitude + currentLocation.coordinate.longitude) / 2
            
            mapView.setCenter(CLLocationCoordinate2D(latitude: centerCoordinateLatitude, longitude: centerCoordinateLongitude), animated: true)
            print(centerCoordinateLatitude)
            print(centerCoordinateLongitude)
        }else {
            mapView.setCenter(destinationClassroom.coordinate, animated: true)
        }
    }
    
    @IBAction func unwindSegue(_ sender: UIButton) {
        if currentLocationChanged {
            performSegue(withIdentifier: "unwindToVCClassroomCurrentLocation", sender: self)
        } else {
            performSegue(withIdentifier: "unwindToVCClassroomDestinationPick", sender: self)
        }
    }
}
