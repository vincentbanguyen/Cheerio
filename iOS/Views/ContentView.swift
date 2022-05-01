import SwiftUI

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

struct ContentView: View {
    
    @State var completedTask = false
    let width = screenWidth * 0.8
    var body: some View {
        ZStack {
            Color(hex: "#3c3c3c")
                .ignoresSafeArea()
        VStack(spacing: 45) {
            ZStack {
                Image("Background")
                    .scaleEffect(0.2)
                    .frame(width: width, height: 200)
                    .aspectRatio(contentMode: .fit)
                if !completedTask {
                    LottieView(name: "dog_idle", loopMode: .loop)
                        .scaleEffect(2.5)
                        .frame(width: width, height: 120)
                        .aspectRatio(contentMode: .fit)
                } else {
                    LottieView(name: "dog_eating", loopMode: .loop)
                        .scaleEffect(2.5)
                        .frame(width: width, height: 120)
                        .aspectRatio(contentMode: .fit)
                }
                
            }
            
            TaskListView(completedTask: $completedTask)
                .padding()
        }
        .padding(.top, 65)
    }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
