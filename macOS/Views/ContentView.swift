import SwiftUI

var keyValStore = NSUbiquitousKeyValueStore()

struct ContentView: View {
    
    @State var completedTask = false
    @State var completedTasks = "0"
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Rectangle()
                        .frame(width: 65, height: 20)
                        .foregroundColor(completedTasks > "0" ? .yellow : .gray)
                        .cornerRadius(5)
                    Rectangle()
                        .frame(width: 65, height: 20)
                        .foregroundColor(completedTasks > "1" ? .yellow : .gray)
                        .cornerRadius(5)
                    Rectangle()
                        .frame(width: 65, height: 20)
                        .foregroundColor(completedTasks > "2" ? .yellow : .gray)
                        .cornerRadius(5)
                }
                Image("cheerio")
                    .scaleEffect(0.016)
                    .frame(width: 20, height: 20)
                    .aspectRatio(contentMode: .fit)
                    .onTapGesture {
                        keyValStore.set(0, forKey: "completedTasks")
                        completedTasks = String(0)
                        print("num completed tasks: \(completedTasks)")
                        keyValStore.synchronize()
                    }
                Text(completedTasks)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
            }
            .padding(.bottom, 35)
            .padding()
            
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
            .padding(.bottom, 45)
            
            TaskListView(completedTask: $completedTask, completedTasks: $completedTasks)
                .padding()
        }
        .padding(.top, 10)
        .onAppear {
            completedTasks = keyValStore.string(forKey: "completedTasks") ?? "0"
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
