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

        NavigationStack {

            VStack(spacing: 20) {
            
                Text("Get Ready to Cry")

                    .font(.largeTitle)

                    .fontWeight(.bold)

                    .foregroundColor(.purple)

                    .padding(.top, 40)

                

                if isLoading {

                    ProgressView("Fetching wholesome memes...")

                        .padding()

                } else if !memeImageUrl.isEmpty {

                    Text(memeTitle)

                        .font(.headline)

                        .multilineTextAlignment(.center)

                        .padding()

                    

                    if let url = URL(string: memeImageUrl) {

                        AsyncImage(url: url) { image in

                            image

                                .resizable()

                                .scaledToFit()

                                .frame(maxWidth: 300, maxHeight: 300)

                                .cornerRadius(15)

                                .shadow(radius: 5)

                        } placeholder: {

                            ProgressView()

                        }

                        .padding()

                    }

                } else {

                    Text("Press the button to get moved to tears!")

                        .font(.title2)

                        .multilineTextAlignment(.center)

                        .padding()

                }

                

                Button(action: {

                    Task {

                        await fetchMeme()

                    }

                }) {

                    HStack {

                        Image(systemName: "drop.fill")

                            .font(.title2)

                        Text("Get Moved to Tears")

                            .font(.title2)

                            .fontWeight(.semibold)

                    }

                    .foregroundColor(.white)

                    .frame(maxWidth: .infinity)

                    .padding()

                    .background(

                        LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing)

                    )

                    .cornerRadius(15)

                    .shadow(radius: 5)

                }

                .padding(.horizontal)

                

                Spacer()

            }

            .padding()

        }

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
