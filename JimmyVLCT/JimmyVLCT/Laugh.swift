//
//  Laugh.swift
//  JimmyVLCT
//
//  Created by Dylan Borgio on 11/11/24.
//
import WebKit
import SwiftUI
struct Laugh: View {
    @State var animateGradient = false
    @State var quote = [Quote]()
    
    @State var randomInt = Int.random(in: 0..<300)
    @State var joke = ""
    @State var punch = ""
    @State private var selectedVideoURL: URL? = nil
    let happyVideos: [URL] = [ URL(string: "https://www.youtube.com/watch?v=y0sF5xhGreA")!, URL(string: "https://www.youtube.com/watch?v=BOK8T1HK4S8")!, URL(string: "https://www.youtube.com/watch?v=tpiyEe_CqB4")!, URL(string: "https://www.youtube.com/watch?v=cytJLvf-eVs")!, URL(string: "https://www.youtube.com/watch?v=n2JwA4Ngbf4")!, URL(string: "https://www.youtube.com/watch?v=pxn0wL_uSm4")!, URL(string: "https://www.youtube.com/watch?v=jfd9CDbB548")!, URL(string: "https://www.youtube.com/watch?v=RCgIYbBf0fU")!, URL(string: "https://www.youtube.com/watch?v=Gm3VCq1YGJg")!, URL(string: "https://www.youtube.com/watch?v=GJ62u8hvlEc")!, URL(string: "https://www.youtube.com/watch?v=IhD2QihfZOw")!, URL(string: "https://www.youtube.com/watch?v=RJIN7jCyspU")!, URL(string: "https://www.youtube.com/watch?v=VrFjxiQgq_4")!, URL(string: "https://www.youtube.com/watch?v=1Gv6Jqlwe9w")!, URL(string: "https://www.youtube.com/watch?v=Dd7FixvoKBw")!, URL(string: "https://www.youtube.com/watch?v=zB7MichlL1k")!, URL(string: "https://www.youtube.com/watch?v=hMQ2qGmJOVM")!, URL(string: "https://www.youtube.com/watch?v=9-GRzu6zbS0")!, URL(string: "https://www.youtube.com/watch?v=3znzIslrQXg")!, URL(string: "https://www.youtube.com/watch?v=SxwMTAy1gP0")!, URL(string: "https://www.youtube.com/watch?v=kvLXPcDZxE0")!, URL(string: "https://www.youtube.com/watch?v=pZ6o_eabZTg")! ]
    var body: some View {
        VStack {
            Text(joke)
                .padding()
            Text(punch)
                .padding()
            Button(action: {
                randomInt = Int.random(in: 0..<300)
                joke = quote[randomInt].setup
                punch = quote[randomInt].punchline
            }, label: {
                ZStack {
                    
                    Text("Get another Joke! 🤣")
                        .foregroundColor(.white)
                        .frame(maxWidth: 200, maxHeight: 10)
                        .padding()
                        .background(
                            LinearGradient(gradient: Gradient(colors: [.red, .yellow]), startPoint: .leading, endPoint: .trailing)
                        )
                        .cornerRadius(15)
                        .shadow(radius: 5)
                        .padding(.horizontal)
                        .padding()
                    
                }
            })
            Button(action: {
                if let url = happyVideos.randomElement() {
                    selectedVideoURL = url
                }
            }, label: {
                Text("Watch Random Video 🤣")
                    .foregroundColor(.white)
                    .frame(maxWidth: 200, maxHeight: 10)
                    .padding()
                    .background(
                        LinearGradient(gradient: Gradient(colors: [.red, .yellow]), startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(15)
                    .shadow(radius: 5)
                    .padding(.horizontal)
                
                })
            .sheet(item: $selectedVideoURL) { url in
                Web2View(url: url)
            }
            
            
            
        }
        
        .padding(.horizontal)
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            LinearGradient(colors: [.yellow, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                .hueRotation(.degrees(animateGradient ? 0: 5))
                .onAppear {
                    withAnimation(.easeInOut(duration: 10).repeatForever(autoreverses: true)) {
                        animateGradient.toggle()
                    }
                }
        }
        
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
    Laugh()
}


struct Web2View: UIViewRepresentable {
    
    let url: URL
    
    
    
    func makeUIView(context: Context) -> WKWebView {
        
        return WKWebView()
        
    }
    
    
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
        let request = URLRequest(url: url)
        
        uiView.load(request)
        
    }
    
   
}
#Preview {
    Laugh()
}
