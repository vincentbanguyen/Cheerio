import SwiftUI

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

var keyValStore = NSUbiquitousKeyValueStore()

struct ContentView: View {
    
    @State var completedTask = false
    @State var completedTasks = "0"
    let width = screenWidth * 0.8
    var body: some View {
        ZStack {
            
            VStack {
                HStack {
                    HStack {
                        Rectangle()
                            .frame(width: width * 0.27, height: 30)
                            .foregroundColor(completedTasks > "0" ? .yellow : .gray)
                            .cornerRadius(5)
                        Rectangle()
                            .frame(width: width * 0.27, height: 30)
                            .foregroundColor(completedTasks > "1" ? .yellow : .gray)
                            .cornerRadius(5)
                        Rectangle()
                            .frame(width: width * 0.27, height: 30)
                            .foregroundColor(completedTasks > "2" ? .yellow : .gray)
                            .cornerRadius(5)
                    }
                    Image("cheerio")
                        .scaleEffect(0.03)
                        .frame(width: 30, height: 30)
                        .aspectRatio(contentMode: .fit)
                        .onTapGesture {
                            keyValStore.set(0, forKey: "completedTasks")
                            completedTasks = String(0)
                            print("num completed tasks: \(completedTasks)")
                            keyValStore.synchronize()
                        }
                    Text(completedTasks)
                        .font(.system(size: 30, weight: .semibold, design: .rounded))
                }
                .padding(.bottom, 15)
                .padding()
                
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
                .padding(.top, 20)
                .padding(.bottom, 40)
                
                TaskListView(completedTask: $completedTask, completedTasks: $completedTasks)
                    .padding()
            }
            .padding(.top, 25)
        }
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
