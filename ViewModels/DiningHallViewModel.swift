//
//  DiningHallViewModel.swift
//  PennDiningHunt
//
//  Created by user268934 on 11/1/24.
//

import SwiftUI
import CoreLocation

class DiningHallViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var diningHalls: [DiningHall]
    @Published var userLocation: CLLocation?
    private var locationManager = CLLocationManager()
    
    let proximityThreshold: Double = 50.0
    
    override init() {
        self.diningHalls = DiningHall.diningList
        super.init()
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        userLocation = newLocation
        print("Updated user location: \(newLocation)" )
    }
    
    func collectDiningHall(_ hall: DiningHall) {
        if let index = diningHalls.firstIndex(where: { $0.id == hall.id }) {
            diningHalls[index].isCollected = true
        }
    }
    
    func isWithinProximity(hallLocation: CLLocationCoordinate2D) -> Bool {
            guard let userLocation = userLocation else { return false }
            let hallCLLocation = CLLocation(latitude: hallLocation.latitude, longitude: hallLocation.longitude)
            return userLocation.distance(from: hallCLLocation) <= proximityThreshold
    }
    
    func hasBeenCollected(_ hall: DiningHall) -> Bool {
        return hall.isCollected
    }
}
