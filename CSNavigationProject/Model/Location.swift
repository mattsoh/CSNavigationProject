//
//  Location.swift
//  CSNavigationProject
//
//  Created by Matthew Soh on 10/4/23.
//

import Foundation
import MapKit

class Location: NSObject, MKAnnotation {
    var name: String
    var type: String
    var coordinate: CLLocationCoordinate2D
    
    var dictionary: [String:Any] {
        return ["name": name, "type": type]
    }
    
    var title: String? {
        return name
    }
    var subtitle: String? {
        return type
    }
    
    init(name: String, type: String, coordinate: CLLocationCoordinate2D
    ) {
        self.name = name
        self.type = type
        self.coordinate = coordinate
    }
    
    convenience override init() {
        self.init(name: "", type: "", coordinate: CLLocationCoordinate2D())
    }
    
    convenience init(dictionary: [String: Any]) {
        let name = dictionary["name"] as! String? ?? ""
        let type = dictionary["type"] as! String? ?? ""
        self.init(name: name, type: type, coordinate: CLLocationCoordinate2D())
    }
}
