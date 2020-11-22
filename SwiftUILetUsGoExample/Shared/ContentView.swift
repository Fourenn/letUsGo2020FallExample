//
//  ContentView.swift
//  Shared
//
//  Created by Fourenn on 2020/11/21.
//

import SwiftUI

struct ContentView: View {

  var body: some View {
    #if os(iOS)
    ConferenceHome()
    #else
    DragAndDropExample()
    #endif
  }
}

// MARK: - Previews

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    #if os(iOS)
    ConferenceHome()
      .environmentObject(Conference())
    #else
    DragAndDropExample()
    #endif
  }
}
