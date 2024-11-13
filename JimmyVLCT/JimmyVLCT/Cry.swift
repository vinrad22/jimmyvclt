//
//  Cry.swift
//  JimmyVLCT
//
//  Created by Dylan Borgio on 11/11/24.
//

import SwiftUI

struct Cry: View {
    
    @State private var memeTitle: String = ""
    @State private var memeImageUrl: String = ""
    @State private var isLoading = false
    
    var body: some View {
        VStack {
            if isLoading {
                ProgressView()
            } else if !memeImageUrl.isEmpty {
                Text(memeTitle)
                    .font(.headline)
                    .padding()
                
                if let url = URL(string: memeImageUrl) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(maxWidth: 300, maxHeight: 300)
                    .padding()
                }
            } else {
                Text("Press the button to get moved to tears!")
                    .padding()
            }
            
            Button(action: {
                Task {
                    await fetchMeme()
                }
            }, label: {
                Text("Get Moved to Tears")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            })
            .padding()
            
            Spacer()
        }
        .padding()
    }
    
    func fetchMeme() async {
        isLoading = true
        defer { isLoading = false }
        
        let urlString = "https://www.reddit.com/r/wholesomememes/random/.json"
        
        guard let url = URL(string: urlString) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
               let firstObject = jsonArray.first,
               let dataDict = firstObject["data"] as? [String: Any],
               let children = dataDict["children"] as? [[String: Any]],
               let firstChild = children.first,
               let childData = firstChild["data"] as? [String: Any] {
                
                memeTitle = childData["title"] as? String ?? "No Title"
                memeImageUrl = childData["url"] as? String ?? ""
            }
        } catch {
            print("Error fetching meme: \(error)")
        }
    }
}

#Preview {
    Cry()
}

