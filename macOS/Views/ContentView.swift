import SwiftUI

struct ContentView: View {
    
    @State var completedTask = false
    
    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                Image("Background")
                    .scaleEffect(0.1)
                    .frame(width: 100, height: 100)
                    .aspectRatio(contentMode: .fit)
                if !completedTask {
                    LottieView(name: "dog_idle", loopMode: .loop)
                        .scaleEffect(0.1)
                        .frame(width: 100, height: 100)
                        .aspectRatio(contentMode: .fit)
                } else {
                    LottieView(name: "dog_eating", loopMode: .loop)
                        .scaleEffect(0.1)
                        .frame(width: 100, height: 100)
                        .aspectRatio(contentMode: .fit)
                }
                
            }
            
            TaskListView(completedTask: $completedTask)
                .padding()
        }
        .padding(.top, 40)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
