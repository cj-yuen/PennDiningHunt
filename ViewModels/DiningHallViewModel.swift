//
//  DiningHallViewModel.swift
//  PennDiningHunt
//
//  Created by user268934 on 11/1/24.
//

import SwiftUI
import CoreLocation
import CoreMotion

class DiningHallViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var diningHalls: [DiningHall]
    @Published var userLocation: CLLocation?
    private var locationManager = CLLocationManager()
    private let motionManager = CMMotionManager()
    private let threshold: Double = 1.5
    
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
    
    func startMotionDetection(for diningHall: DiningHall) {
        // Prevent starting motion detection if the hall is already collected
        if diningHall.isCollected {
            return
        }

        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.2
            motionManager.startAccelerometerUpdates(to: .main) { [weak self] data, error in
                if let error = error {
                    print("Error receiving motion data: \(error.localizedDescription)")
                }
                if let data = data {
                    let acceleration = data.acceleration
                    if abs(acceleration.x) > self?.threshold ?? 0 ||
                        abs(acceleration.y) > self?.threshold ?? 0 ||
                        abs(acceleration.z) > self?.threshold ?? 0 {
                        self?.collectDiningHall(diningHall)
                        self?.stopMotionDetection()
                    }
                }
            }
        } else {
                print("Accelerometer is not available")
        }
    }
        
    func stopMotionDetection() {
        motionManager.stopAccelerometerUpdates()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            requestCurrentLocation()
        case .denied, .restricted:
            print("Location access denied or restricted")
        default:
            break
        }
    }
    
    func requestCurrentLocation() {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        userLocation = newLocation
        print("Updated user location: \(newLocation)" )
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Failed to get user location: \(error.localizedDescription)")
    }
    
    func collectDiningHall(_ hall: DiningHall) {
        // Ensure the dining hall is collected only once
        if let index = diningHalls.firstIndex(where: { $0.id == hall.id }) {
            if !diningHalls[index].isCollected {
                diningHalls[index].isCollected = true
                print("\(hall.name) has been collected!") // Debug confirmation
            }
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
    
    deinit {
        stopMotionDetection()
    }
}
