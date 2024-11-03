//
//  DiningHall.swift
//  PennDiningHunt
//
//  Created by user268934 on 11/1/24.
//

import Foundation
import CoreLocation

class DiningHall: Identifiable, ObservableObject {
    var id: UUID
    var name: String
    var location: CLLocationCoordinate2D
    @Published var isCollected: Bool = false
    
    init(id: UUID, name: String, location: CLLoctionCoordinate2D, isCollected: Bool = false) {
        self.id = id
        self.name = name
        self.location = location
        self.isCollected = isCollected
    }
}
extension DiningHall {
    static let diningList: [DiningHall] = [
            .init(
                id: UUID(),
                name: "1920 Commons",
                location: CLLocationCoordinate2D.commons
            ),
            .init(
                id: UUID(),
                name: "Accenture Café",
                location: CLLocationCoordinate2D.accenture
            ),
            .init(
                id: UUID(),
                name: "Falk Kosher Dining",
                location: CLLocationCoordinate2D.falk
            ),
            .init(
                id: UUID(),
                name: "Hill House",
                location: CLLocationCoordinate2D.hill
            ),
            .init(
                id: UUID(),
                name: "Houston Market",
                location: CLLocationCoordinate2D.houston
            ),
            .init(
                id: UUID(),
                name: "Joe's Café",
                location: CLLocationCoordinate2D.joes
            ),
            .init(
                id: UUID(),
                name: "Kings Court English House",
                location: CLLocationCoordinate2D.kceh
            ),
            .init(
                id: UUID(),
                name: "Lauder House",
                location: CLLocationCoordinate2D.lauder
            ),
            .init(
                id: UUID(),
                name: "McClelland Express",
                location: CLLocationCoordinate2D.mcclelland
            ),
            .init(
                id: UUID(),
                name: "Pret A Manger",
                location: CLLocationCoordinate2D.pret
            ),
            .init(
                id: UUID(),
                name: "Quaker Kitchen",
                location: CLLocationCoordinate2D.quaker
            ),
        ]
}
