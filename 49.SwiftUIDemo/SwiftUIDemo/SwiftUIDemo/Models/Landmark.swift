//
//  Landmark.swift
//  SwiftUIDemo
//
//  Created by jackfrow on 2021/5/13.
//

import Foundation
import SwiftUI
import MapKit


struct Landmark:Decodable,Identifiable {
    var id: Int
    var name: String
    var park: String
    var state: String
    var description: String
    var isFavorite: Bool
    
    //image
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
    
    var locationCoordinate: CLLocationCoordinate2D {
         CLLocationCoordinate2D(
             latitude: coordinates.latitude,
             longitude: coordinates.longitude)
     }
    
    //coordinate
    private var coordinates: Coordinates

    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
}




