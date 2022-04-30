//
//  ContentView.swift
//  Cheerio (macOS)
//
//  Created by Vincent Nguyen on 4/30/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TaskListView()
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
