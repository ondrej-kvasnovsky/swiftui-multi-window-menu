//
//  multi_window_menuApp.swift
//  multi-window-menu
//
//  Created by Ondrej Kvasnovsky on 7/3/21.
//

import SwiftUI

@main
struct multi_window_menuApp: App {
  
  @State var globalViewModel = GlobalViewModel()
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(self.globalViewModel)
    }
    .commands {
      MenuCommands(globalViewModel: self.globalViewModel)
    }
    
    Settings {
      VStack {
        Text("My Settingsview")
      }
    }
  }
}
