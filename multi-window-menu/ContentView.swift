//
//  ContentView.swift
//  multi-window-menu
//
//  Created by Ondrej Kvasnovsky on 7/3/21.
//

import SwiftUI

struct ContentView: View {
  @StateObject var viewModel: ViewModel  = ViewModel()
  
  var body: some View {
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
