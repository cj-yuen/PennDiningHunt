//
//  DiningHallDetailView.swift
//  PennDiningHunt
//
//  Created by Kevin D on 11/2/24.
//

import SwiftUI
import CoreMotion

struct DiningHallDetailView: View {
    @ObservedObject var viewModel: DiningHallViewModel
    var diningHall: DiningHall
    private let motionManager = CMMotionManager()

    var body: some View {
        VStack {
            Text(diningHall.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            if (diningHall.isCollected) {
                Text("Already Collected!")
                    .font(.title)
                    .padding()
            } else if (!viewModel.isWithinProximity(hallLocation: diningHall.location)) {
                Text("Not in range. Get within 50m to collect!")
                    .font(.title)
                    .padding()
            } else {
                Text("Shake screen to collect!")
                    .onAppear{
                        startMotionDetection()
                    }
                    .font(.title)
                    .padding()
            }
            
        }
        .onDisappear {
            stopMotionDetection()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(diningHall.isCollected ? .green : .red)
        .navigationTitle(diningHall.name)
        
    }
                       
    func startMotionDetection() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.2
            motionManager.startAccelerometerUpdates(to: .main) { data, error in
                if let data = data {
                    let acceleration = data.acceleration
                    let threshold: Double = 0.5
                    if abs(acceleration.x) > threshold || abs(acceleration.y) > threshold || abs(acceleration.z) > threshold {
                        viewModel.collectDiningHall(diningHall)
                        stopMotionDetection()
                    }
                }
            }
        }
    }
                           
    func stopMotionDetection() {
        motionManager.stopAccelerometerUpdates()
    }
}
