//
//  ContentView.swift
//  PennDiningHunt
//
//  Created by Kevin D on 10/28/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack() {
            VStack {
                Text("Penn Dining Hunt!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 30)
                Text("Kevin Du & Chris Yuan")
                    .fontWeight(.bold)
                    .fontWidth(.expanded)
                    .padding()
                    .frame(maxWidth: 350, maxHeight: 200)
                    .padding(.bottom, 90)
                
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 0.8, green: 0.7, blue: 1))
        }
    }
}

#Preview {
    ContentView()
}
