import SwiftUI

struct ContentView: View {
  
    var body: some View {
        NavigationStack {
            VStack() {
                
                Text("Daily Emotions")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 40)
                    .foregroundColor(.cyan)
                
                Text("Welcome!")
                    .font(.title)
                    .fontWeight(.semibold)
                   .padding(.bottom, 30)
                
                
                
                // Button to View 3
                NavigationLink(destination: Laugh().navigationTitle("Laugh").fontDesign(.serif)) {
                    HStack {
                        Image(systemName: "smiley.fill")
                            .font(.title2)
                        Text("Laugh")
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(gradient: Gradient(colors: [.red, .yellow]), startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(15)
                    .shadow(radius: 5)
                    .padding(.horizontal)
                }
                .navigationTitle("")
                .padding()
            }
          
            
               
            // Button to View 1
            NavigationLink(destination: Cry()) {
                HStack {
                    Image(systemName: "cloud.rain.fill")
                        .font(.title2)
                    Text("Cry")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    LinearGradient(gradient: Gradient(colors:   [.blue, .purple]), startPoint: .leading, endPoint: .trailing)
                )
                .cornerRadius(15)
                .shadow(radius: 5)
                .padding()
                
            }
            .padding(.horizontal)
            
            // Button to View 2
            NavigationLink(destination: Think()) {
                HStack {
                    Image(systemName: "brain.head.profile")
                        .font(.title2)
                    Text("Think")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    LinearGradient(gradient: Gradient(colors: [.green, .teal]), startPoint: .leading, endPoint: .trailing)
                )
                .cornerRadius(15)
                .shadow(radius: 5)
                .padding()
                
                
            }
            .padding(.horizontal)
         //   .background(Color(.systemGroupedBackground))
        }
        
    }
}


// Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


