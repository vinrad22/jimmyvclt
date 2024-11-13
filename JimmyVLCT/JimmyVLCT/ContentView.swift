//
//  ContentView.swift
//  JimmyVLCT
//
//  Created by Vincent M. Radlicz on 11/4/24.
//

import SwiftUI

struct ContentView: View {
   
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
              
                Text("Welcome!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 40)
                
                // Button to View 1
                NavigationLink(destination: Laugh()) {
                    Text("Go to Laugh View")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        
                }
                .padding()
                // Button to View 2
                NavigationLink(destination: Cry()) {
                    Text("Go to Cry View")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        
                }
                .padding()
                // Button to View 3
                NavigationLink(destination: Think()) {
                    Text("Go to Think View")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding()
                Spacer()
            }
            .padding()
            .navigationTitle("Main Menu")
            .padding(.bottom, 40)
        }
    }
}
#Preview {
    ContentView()
}

// Placeholder Views for the destination views



// Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

