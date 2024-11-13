//
//  Think.swift
//  JimmyVLCT
//
//  Created by Dylan Borgio on 11/11/24.
//


import SwiftUI

import WebKit



struct WebView: UIViewRepresentable {

    let url: URL

    

    func makeUIView(context: Context) -> WKWebView {

        return WKWebView()

    }

    

    func updateUIView(_ uiView: WKWebView, context: Context) {

        let request = URLRequest(url: url)

        uiView.load(request)

    }

}



struct Think: View {

    @State private var currentThought: String = ""

    @State private var selectedVideoURL: URL? = nil

    @State private var isVideoPlayerPresented: Bool = false

    

    let showerThoughts: [String] = [

        "Why do we drive on parkways and park on driveways?",

        "Your age is just the number of times you've orbited the sun.",

        "At one point, you were the youngest person in the world.",

        "Every 'mirror' you buy in a store is used.",

        "Your brain named itself.",

        "You never actually see your real face, only reflections or pictures of it.",

        "Technically, a ghost could be using your Wi-Fi, and you’d never know.",

        "Nothing is on fire; fire is on things.",

        "Your belly button is your old mouth.",

        "History classes are only going to get longer as time goes on.",

        "When you clean out a vacuum cleaner, you become a vacuum cleaner.",

        "You’ve never been in an empty room, only a room without people.",

        "When you say 'forward' or 'backward,' your lips move in those directions.",

        "Your future self is watching you right now through memories.",

        "You could be walking past someone who will one day attend your funeral.",

        "When you drink water, it’s technically older than the solar system.",

        "The word 'silent' and the word 'listen' are made of the same letters.",

        "You are made of stardust.",

        "The tallest person you’ve ever met was once the shortest person you’ve ever met.",

        "Your tongue knows exactly how everything you look at would feel.",

        "Humans invented the sounds of dinosaurs.",

        "Every time you paint a room, it gets smaller.",

        "The first person to see a parrot must have been incredibly confused.",

        "The moon is moving away from Earth, and you will never know how close it was the day you were born.",

        "You are both the oldest and youngest person you've ever been.",

        "What if oxygen is poisonous, but it takes 80 years to kill us?",

        "When you say 'LOL,' you're usually not actually laughing out loud.",

        "A moment you vividly remember might not be remembered by anyone else.",

        "The letters 'X' and 'Y' have no purpose in the English alphabet, but they're still there.",

        "If time travel is ever invented, someone from the future could be watching you now.",

        "You don’t know how many people are thinking about you right now.",

        "Everything in your house will outlive you.",

        "You’re the only person who has heard your whole life from your perspective.",

        "If you think about it, every villain is the hero of their own story.",

        "We all start life with a clean slate, but some of us get different chalk.",

        "The light you see from stars is older than every human civilization.",

        "The 's' in 'lisp' makes the word harder for people with a lisp to say.",

        "If you live to be 90, you will have spent 30 years of your life sleeping.",

        "Your phone is a collection of metals, yet it feels alive when it vibrates.",

        "If aliens are watching us, they must be really confused about our obsession with cats.",

        "The present is the past of your future self.",

        "The sky isn't blue; it's every color, but we see blue because of the way light scatters.",

        "You never know the exact moment when you fall asleep.",

        "Technically, everyone has infinite ancestors because each person has two parents.",

        "There’s no physical evidence that today is Wednesday; we all just trust the calendar.",

        "You’ve probably walked past someone who’s having the worst day of their life.",

        "Your hand size hasn’t changed much since you were a kid; only your perspective did.",

        "Humans are the only species that pay to live on Earth.",

        "The brain named itself and decided it was the most important organ.",

        "It’s weird that we have to live our whole lives on the crust of a massive rock.",

        "The sound of your heartbeat is the theme song to your life.",

        "Once you’ve made a footprint, it’s already in your past.",

        "We know more about the surface of the moon than the ocean floor.",

        "You’ve likely walked past someone who’s in the background of your photos."

    ]

    

    let thinkVideos: [URL] = [

        URL(string: "https://www.youtube.com/watch?v=h-QNH6zwwUY")!,

        URL(string: "https://www.youtube.com/watch?v=vddQBOMYlb8")!,

        URL(string: "https://www.youtube.com/watch?v=nIzo8dbvPwY")!,

        URL(string: "https://www.youtube.com/watch?v=2fXSMXGUw6E")!,

        URL(string: "https://www.youtube.com/watch?v=pFwulbp15Z4")!,

        URL(string: "https://www.youtube.com/watch?v=b-XK0gUkgyA")!,

        URL(string: "https://www.youtube.com/watch?v=KIbmUUJW02w")!,

        URL(string: "https://www.youtube.com/watch?v=hHJkB6PZbGg")!,

        URL(string: "https://www.youtube.com/watch?v=riHpKhUpbRI")!

    ]

    

    var body: some View {

        VStack {

            Text("Shower Thoughts")

                .font(.largeTitle)

                .padding()

            

            Text(currentThought)

                .font(.headline)

                .multilineTextAlignment(.center)

                .padding()

                .frame(maxHeight: 200)

            

            Button(action: {

                currentThought = showerThoughts.randomElement() ?? "No thoughts available."

            }) {

                Text("Get a Shower Thought")

                    .padding()

                    .background(Color.blue)

                    .foregroundColor(.white)

                    .cornerRadius(10)

            }

            .padding(.bottom)

            

            Button(action: {

                selectedVideoURL = thinkVideos.randomElement()

                isVideoPlayerPresented = true

            }) {

                Text("Watch a Random Think Video")

                    .padding()

                    .background(Color.green)

                    .foregroundColor(.white)

                    .cornerRadius(10)

            }

            .sheet(isPresented: $isVideoPlayerPresented) {

                if let url = selectedVideoURL {

                    WebView(url: url)

                }

            }

        }

        .padding()

    }

}



struct ShowerThoughtsView_Previews: PreviewProvider {

    static var previews: some View {

        Think()

    }

}
