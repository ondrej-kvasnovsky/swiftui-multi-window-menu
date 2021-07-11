//
//  ContentView.swift
//  multi-window-menu
//
//  Created by Ondrej Kvasnovsky on 7/3/21.
//

import SwiftUI

class GlobalViewModel : NSObject, ObservableObject {
  
  // all currently opened windows
  @Published var windows = Set<NSWindow>()
  
  // all view models that belong to currently opened windows
  @Published var viewModels : [Int:ViewModel] = [:]
  
  // currently active aka selected aka key window
  @Published var activeWindow: NSWindow?
  
  // currently active view model for the active window
  @Published var activeViewModel: ViewModel?
  
  func addWindow(window: NSWindow) {
    window.delegate = self
    windows.insert(window)
  }
  
  // associates a window number with a view model
  func addViewModel(_ viewModel: ViewModel, forWindowNumber windowNumber: Int) {
    viewModels[windowNumber] = viewModel
  }
}

extension GlobalViewModel : NSWindowDelegate {
  func windowWillClose(_ notification: Notification) {
    if let window = notification.object as? NSWindow {
      windows.remove(window)
      viewModels.removeValue(forKey: window.windowNumber)
      print("Open Windows", windows)
      print("Open Models", viewModels)
      // windows = windows.filter { $0.windowNumber != window.windowNumber }
    }
  }
  func windowDidBecomeKey(_ notification: Notification) {
    if let window = notification.object as? NSWindow {
      print("Activating Window", window.windowNumber)
      activeWindow = window
      activeViewModel = viewModels[window.windowNumber]
    }
  }
}

struct HostingWindowFinder: NSViewRepresentable {
  var callback: (NSWindow?) -> ()
  
  func makeNSView(context: Self.Context) -> NSView {
    let view = NSView()
    DispatchQueue.main.async { [weak view] in
      self.callback(view?.window)
    }
    return view
  }
  func updateNSView(_ nsView: NSView, context: Context) {}
}

struct ContentView: View {
  @EnvironmentObject var globalViewModel : GlobalViewModel
  
  @StateObject var viewModel: ViewModel  = ViewModel()
  
  var body: some View {
    HostingWindowFinder { window in
      if let window = window {
        self.globalViewModel.addWindow(window: window)
        print("New Window", window.windowNumber)
        self.globalViewModel.addViewModel(self.viewModel, forWindowNumber: window.windowNumber)
      }
    }
    
    TextField("", text: $viewModel.inputText)
      .disabled(true)
      .padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
