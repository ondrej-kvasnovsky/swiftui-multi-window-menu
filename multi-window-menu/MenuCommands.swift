//
//  MenuCommands.swift
//  multi-window-menu
//
//  Created by Ondrej Kvasnovsky on 7/3/21.
//

import Foundation
import SwiftUI
import Combine

struct MenuCommands: Commands {
  var globalViewModel: GlobalViewModel
  
  var body: some Commands {
    CommandGroup(after: CommandGroupPlacement.newItem, addition: {
      Divider()
      Button(action: {
        let dialog = NSOpenPanel();
        
        dialog.title = "Choose a file";
        dialog.showsResizeIndicator = true;
        dialog.showsHiddenFiles = false;
        dialog.allowsMultipleSelection = false;
        dialog.canChooseDirectories = false;
        
        if (dialog.runModal() ==  NSApplication.ModalResponse.OK) {
          let result = dialog.url
          if (result != nil) {
            let path: String = result!.path
            do {
              let string = try String(contentsOf: URL(fileURLWithPath: path), encoding: .utf8)
              print("Active Window", self.globalViewModel.activeWindow?.windowNumber)
              self.globalViewModel.activeViewModel?.inputText = string
            }
            catch {
              print("Error \(error)")
            }
          }
        } else {
          return
        }
      }, label: {
        Text("Open File")
      })
      .keyboardShortcut("O", modifiers: [.command])
    })
  }
}
