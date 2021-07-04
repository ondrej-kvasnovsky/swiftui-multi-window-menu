//
//  multi_window_menuApp.swift
//  multi-window-menu
//
//  Created by Ondrej Kvasnovsky on 7/3/21.
//

import SwiftUI

@main
struct multi_window_menuApp: App {

  var body: some Scene {
    WindowGroup {
      ContentView()
    }.commands {
      MenuCommands()
    }
  }
}
