//
//  Laugh.swift
//  JimmyVLCT
//
//  Created by Dylan Borgio on 11/11/24.
//
import SwiftUI
struct Laugh: View {
    @State var quote = [Quote]()
    
    @State var randomInt = Int.random(in: 0..<300)
    @State var joke = ""
    @State var punch = ""
    var body: some View {
        VStack {
            Text(joke)
            Text(punch)
        }
        .padding()
        .task {
            await getData()
            joke = quote[randomInt].setup
            punch = quote[randomInt].punchline
        }
        
    }
        
    func getData() async {
        
        guard let url = URL(string: "https://api.sampleapis.com/jokes/goodJokes") else {
            print("error1")
            return
        }
        do {
            let (data, _ ) = try await URLSession.shared.data(from: url)
             if let decodedResponse = try? JSONDecoder().decode([Quote].self, from: data) {
                 quote = decodedResponse
               
            } else {
                print("no7")
            }
        } catch {
            print("error")
        }
    }
}

struct Quote: Codable {
    var setup: String
    var punchline: String
    
}

#Preview {
    ContentView()
}

