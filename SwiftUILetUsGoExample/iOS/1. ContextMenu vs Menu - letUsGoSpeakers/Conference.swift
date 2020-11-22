//
//  Conference.swift
//  SwiftUILetUsGoExample (iOS)
//
//  Created by Fourenn on 2020/11/21.
//

import SwiftUI

final class Conference: ObservableObject {
  @Published private(set) var sessions: [Session] = letUsGo2020FallSessions

  var watchedSessions: [Session] {
    sessions.filter { $0.isWatched }
  }

  func isWatchedSession(id: Int) -> Bool {
    sessions
      .filter { $0.id == id }
      .map(\.isWatched)
      .first ?? false
  }

  func toggleWatchedSession(id: Int) {
    guard let index = sessions.firstIndex(where: { $0.id == id }) else { return }
    sessions[index].isWatched.toggle()
  }
}

