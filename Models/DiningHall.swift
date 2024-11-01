//
//  DiningHall.swift
//  PennDiningHunt
//
//  Created by user268934 on 11/1/24.
//

import Foundation
import CoreLocation

struct DiningHall: Identifiable {
    var id: UUID
    var name: String
    var location: CLLocation
    var isCollected: Bool = false
}
