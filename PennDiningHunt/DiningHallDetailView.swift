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
   @ObservedObject var diningHall: DiningHall

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
                        viewModel.startMotionDetection(for: diningHall)
                    }
                    .font(.title)
                    .padding()
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(diningHall.isCollected ? .green : .red)
        .navigationTitle(diningHall.name)
        
        
        .onDisappear {
            viewModel.stopMotionDetection()
        }
    }
}
