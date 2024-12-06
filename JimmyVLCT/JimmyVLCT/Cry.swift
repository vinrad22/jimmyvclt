import SwiftUI

struct Cry: View {
    @State private var memeTitle: String = ""
    @State private var memeImageUrl: String = ""
    @State private var poemTitle: String = "AI-Generated Poem"
    @State private var poemContent: String = ""
    @State private var isLoadingMeme = false
    @State private var isLoadingPoem = false

    // Timer for updating content
    @State private var timer: Timer? = nil

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    // Header
                    Text("Get Ready to Cry")
                        .font(.system(size: 36, weight: .bold, design: .serif))
                        .foregroundColor(Color(.black))
                        .multilineTextAlignment(.center)
                        .padding(.top, 20)

                    if isLoadingMeme || isLoadingPoem {
                        ProgressView("Loading...")
                            .padding()
                    } else {
                        // Meme Section
                        VStack(spacing: 20) {
                            Text("Today’s Sadness")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.secondary)

                            if !memeImageUrl.isEmpty {
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
                                }

                                Text(memeTitle)
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                                    .padding()
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15)
                            .fill(Color(.purple))
                            .shadow(color: .gray.opacity(0.5), radius: 5))
                            .opacity(0.9)
                        // Poem Section
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Emotional Poem")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.secondary)

                            VStack(alignment: .leading, spacing: 10) {
                                ScrollView {
                                    Text(poemContent)
                                        .font(.body)
                                        .lineSpacing(6)
                                        .multilineTextAlignment(.leading)
                                        .padding()
                                }
                                .frame(maxHeight: 300) // Limit scroll view height
                                .background(Color.white)
                                .cornerRadius(15)
                                .shadow(radius: 5)
                            }
                            .padding()
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 15)
                            .fill(Color(.blue))
                            .shadow(color: .gray.opacity(0.5), radius: 5))
                        .opacity(0.9)
                    }

                    Spacer()

                    // Refresh Buttons
                    HStack {
                        Button(action: {
                            Task { await fetchMeme() }
                        }) {
                            Label("Refresh Today's Sadness", systemImage: "arrow.clockwise")
                                .foregroundColor(.white)
                                .frame(maxWidth: 500, maxHeight: 400)
                                .padding()
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .leading, endPoint: .trailing)
                                )
                                .cornerRadius(15)
                                .shadow(radius: 5)
//                                .padding(.horizontal)
                                .padding()
                        }

                        Button(action: {
                            fetchPoem()
                        }) {
                            Label("Refresh Today's Poem", systemImage: "arrow.clockwise")
                                .foregroundColor(.white)
                                .frame(maxWidth: 500, maxHeight: 400)
                                .padding()
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing)
                                )
                                .cornerRadius(15)
                                .shadow(radius: 5)
//                                .padding(.horizontal)
                                .padding()
                        }
                    }
                    .padding(.horizontal)
                }
                .padding()
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.purple, Color.blue]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .opacity(0.5) // Set the desired opacity here
                .ignoresSafeArea()
            

            )
            .onAppear {
                setupTimer()
                Task {
                    await fetchContent()
                }
            }
            .onDisappear {
                timer?.invalidate()
            }
        }
    }

    func setupTimer() {
        let currentTime = Date()
        let calendar = Calendar.current

        // Calculate the next trigger time at 11:59 PM
        var components = calendar.dateComponents([.year, .month, .day], from: currentTime)
        components.hour = 23
        components.minute = 59
        components.second = 0

        let nextTriggerDate = calendar.date(from: components) ?? currentTime
        let timeInterval = max(nextTriggerDate.timeIntervalSinceNow, 1)

        // Schedule the timer
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { _ in
            Task {
                await fetchContent()
            }
        }
    }

    func fetchContent() async {
        await withTaskGroup(of: Void.self) { group in
            group.addTask {
                await fetchMeme()
            }
            group.addTask {
                fetchPoem()
            }
        }
    }

    func fetchMeme() async {
        isLoadingMeme = true
        defer { isLoadingMeme = false }

        let urlString = "https://www.reddit.com/r/wholesomememes/.json"

        guard let url = URL(string: urlString) else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let dataDict = jsonDict["data"] as? [String: Any],
               let children = dataDict["children"] as? [[String: Any]] {
                
                // Randomly select a post from the fetched data
                if let randomPost = children.randomElement(),
                   let childData = randomPost["data"] as? [String: Any] {
                    memeTitle = childData["title"] as? String ?? "No Title"
                    memeImageUrl = childData["url"] as? String ?? ""
                }
            }
        } catch {
            print("Error fetching today's sadness: \(error)")
        }
    }


    func fetchPoem() {
        guard let url = URL(string: "https://api.groq.com/openai/v1/chat/completions") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer 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", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let prompt = """
        Write an original poem that is sad yet happy, anti-depression, and wholesome. Express feelings of hope and overcoming despair.
        """

        let body: [String: Any] = [
            "model": "llama3-8b-8192",
            "messages": [
                ["role": "user", "content": prompt]
            ],
            "max_tokens": 150,
            "temperature": 0.7
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        isLoadingPoem = true

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    isLoadingPoem = false
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    isLoadingPoem = false
                }
                return
            }

            do {
                let response = try JSONDecoder().decode(GroqResponse.self, from: data)
                DispatchQueue.main.async {
                    poemContent = response.choices.first?.message.content.trimmingCharacters(in: .whitespacesAndNewlines) ?? "No response."
                    isLoadingPoem = false
                }
            } catch {
                print("Decoding error: \(error)")
                DispatchQueue.main.async {
                    isLoadingPoem = false
                }
            }
        }.resume()
    }
}

struct GroqResponse: Decodable {
    struct Choice: Decodable {
        struct Message: Decodable {
            let content: String
        }
        let message: Message
    }
    let choices: [Choice]
}

#Preview {
    Cry()
}
