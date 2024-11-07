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
                NavigationLink(destination: FirstView()) {
                    Text("Go to First View")
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
                NavigationLink(destination: SecondView()) {
                    Text("Go to Second View")
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
                NavigationLink(destination: ThirdView()) {
                    Text("Go to Third View")
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

// Placeholder Views for the destination views
struct FirstView: View {
    var body: some View {
        Text("This is the First View")
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

struct SecondView: View {
    var body: some View {
        Text("This is the Second View")
            .font(.largeTitle)
            .foregroundColor(.green)
    }
}

struct ThirdView: View {
    var body: some View {
        Text("This is the Third View")
            .font(.largeTitle)
            .foregroundColor(.orange)
    }
}

// Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

