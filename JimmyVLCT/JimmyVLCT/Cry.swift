import SwiftUI

struct Cry: View {
    @State private var memeTitle: String = ""
    @State private var memeImageUrl: String = ""
    @State private var poemTitle: String = ""
    @State private var poemContent: String = ""
    @State private var isLoadingMeme = false
    @State private var isLoadingPoem = false

    // Timer for updating content
    @State private var timer: Timer? = nil

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Get Ready to Cry")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.purple)
                        .padding(.top, 40)

                    if isLoadingMeme || isLoadingPoem {
                        ProgressView("Loading...")
                            .padding()
                    } else {
                        if !memeImageUrl.isEmpty {
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
                        }

                        if !poemTitle.isEmpty {
                            VStack(alignment: .leading, spacing: 10) {
                                Text(poemTitle)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)

                                ScrollView {
                                    Text(poemContent)
                                        .font(.body)
                                        .multilineTextAlignment(.leading)
                                        .padding()
                                }
                                .frame(maxHeight: 300) // Limit scroll view height
                                .background(Color(UIColor.secondarySystemBackground))
                                .cornerRadius(15)
                                .shadow(radius: 5)
                            }
                            .padding()
                        }
                    }

                    Spacer()
                }
                .padding()
            }
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
                await fetchPoem()
            }
        }
    }

    func fetchMeme() async {
        isLoadingMeme = true
        defer { isLoadingMeme = false }

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
            print("Error fetching: \(error)")
        }
    }

    func fetchPoem() async {
        isLoadingPoem = true
        defer { isLoadingPoem = false }

        let urlString = "https://www.reddit.com/r/sadpoems/random/.json"

        guard let url = URL(string: urlString) else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
               let firstObject = jsonArray.first,
               let dataDict = firstObject["data"] as? [String: Any],
               let children = dataDict["children"] as? [[String: Any]],
               let firstChild = children.first,
               let childData = firstChild["data"] as? [String: Any] {

                poemTitle = childData["title"] as? String ?? "Untitled"
                poemContent = childData["selftext"] as? String ?? "No content available."
            }
        } catch {
            print("Error fetching: \(error)")
        }
    }
}

#Preview {
    Cry()
}
