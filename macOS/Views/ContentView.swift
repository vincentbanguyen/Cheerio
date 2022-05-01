//
//  ContentView.swift
//  Cheerio (macOS)
//
//  Created by Vincent Nguyen on 4/30/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                Image("Background")
                    .scaleEffect(0.1)
                    .frame(width: 100, height: 100)
                    .aspectRatio(contentMode: .fit)
            LottieView(name: "dog_eating", loopMode: .loop)
                .scaleEffect(0.1)
                .frame(width: 100, height: 100)
                .aspectRatio(contentMode: .fit)
            }
        TaskListView()
            
            .padding()
        }
        .padding(.top, 50)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
