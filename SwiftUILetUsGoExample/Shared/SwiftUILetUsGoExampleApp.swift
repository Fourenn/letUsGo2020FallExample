//
//  SwiftUILetUsGoExampleApp.swift
//  Shared
//
//  Created by Fourenn on 2020/11/21.
//

import SwiftUI

@main
struct SwiftUILetUsGoExampleApp: App {
  #if os(iOS)
  @StateObject private var conference = Conference()
  #endif

  var body: some Scene {
    WindowGroup {
      #if os(macOS)
      ContentView()
      #else
      ContentView()
        .environmentObject(conference)
      #endif
    }
  }
}
