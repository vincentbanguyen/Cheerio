import SwiftUI

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

var keyValStore = NSUbiquitousKeyValueStore()

struct ContentView: View {
    
    @State var completedTask = false
    @State var completedTasks = "0"
    let width = screenWidth * 0.8
    @State private var FX: [DotFX] = []
    @State var isTapped = false
    @State var didFlip = false
    
    var body: some View {
        ZStack {
            Color(hex: "2b2b2e")
                .ignoresSafeArea()
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
                    
                    ForEach(FX) { dot in
                        Image(systemName: "heart.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.red)
                            .frame(width: 30, height: 30)
                            .modifier(ParticlesModifier())
                    }
                    
                    if isTapped == true {
                        LottieView(name: "dog_happy", loopMode: .loop)
                            .scaleEffect(2.5)
                            .frame(width: width, height: 120)
                            .aspectRatio(contentMode: .fit)
                    } else if completedTasks == "3" && didFlip == false {
                        LottieView(name: "dog_flip", loopMode: .loop)
                            .scaleEffect(2.5)
                            .frame(width: width, height: 120)
                            .aspectRatio(contentMode: .fit)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    didFlip = true
                                }
                            }
                       
                    }
                    
                    else if completedTask == false {
                        LottieView(name: "dog_idle", loopMode: .loop)
                            .scaleEffect(2.5)
                            .frame(width: width, height: 120)
                            .aspectRatio(contentMode: .fit)
                    } else if completedTask == true {
                        LottieView(name: "dog_eating", loopMode: .loop)
                            .scaleEffect(2.5)
                            .frame(width: width, height: 120)
                            .aspectRatio(contentMode: .fit)
                    }
                    
                }
                .padding(.top, 20)
                .padding(.bottom, 40)
                .onTapGesture {
                    addDotFX()
                    isTapped = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        isTapped = false
                    }
                    
                }
                
                TaskListView(completedTask: $completedTask, completedTasks: $completedTasks)
                    .padding()
                
            }
            .padding(.top, 25)
        }
        .onAppear {
            completedTasks = keyValStore.string(forKey: "completedTasks") ?? "0"
        }
    }
    func addDotFX() {
        self.FX.append(DotFX())
        if FX.count > 5 {
            FX.removeFirst()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
