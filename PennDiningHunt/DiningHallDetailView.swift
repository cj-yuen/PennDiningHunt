//
//  DiningHallDetailView.swift
//  PennDiningHunt
//
//  Created by Kevin D on 11/2/24.
//

import SwiftUI

struct DiningHallDetailView: View {
    var diningHall: DiningHall

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
            } else if (/* replace with check if within 50 m from dining hall */ false) {
                Text("Not in range. Get within 50m to collect!")
                    .font(.title)
                    .padding()
            } else {
                Text("Shake screen to collect!")
                    .font(.title)
                    .padding()
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(diningHall.isCollected ? .green : .red)
        .navigationTitle(diningHall.name)
    }
}
