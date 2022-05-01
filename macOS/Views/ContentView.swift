import SwiftUI

struct ContentView: View {
    
    @State var completedTask = false
    
    var body: some View {
        VStack(spacing: 45) {
            ZStack {
                Image("Background")
                    .scaleEffect(0.135)
                    .frame(width: 100, height: 100)
                    .aspectRatio(contentMode: .fit)
                if !completedTask {
                    LottieView(name: "dog_idle", loopMode: .loop)
                        .scaleEffect(0.135)
                        .frame(width: 100, height: 100)
                        .aspectRatio(contentMode: .fit)
                } else {
                    LottieView(name: "dog_eating", loopMode: .loop)
                        .scaleEffect(0.135)
                        .frame(width: 100, height: 100)
                        .aspectRatio(contentMode: .fit)
                }
                
            }
            
            TaskListView(completedTask: $completedTask)
                .padding()
        }
        .padding(.top, 65)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
