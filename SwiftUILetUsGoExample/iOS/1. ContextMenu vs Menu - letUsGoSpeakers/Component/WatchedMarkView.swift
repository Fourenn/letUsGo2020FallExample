//
//  WatchedMarkView.swift
//  SwiftUILetUsGoExample (iOS)
//
//  Created by Fourenn on 2020/11/21.
//

import SwiftUI

struct WatchedMarkView: View {
  @EnvironmentObject private var conference: Conference
  let sessionID: Int
  @Binding var latestWatchedSessionID: Int?

  var didWatch: Bool {
    conference.isWatchedSession(id: sessionID)
  }

  var body: some View {
    Button(action: {}, label: {
      Menu {
        baseMenus
      }
      label: {
        Image(systemName: didWatch ? "hand.thumbsup.fill" : "hand.thumbsup")
          .font(.title3)
          .foregroundColor(didWatch ? .orange : .white)
          .shadow(radius: 2)
      }
    })

    .padding(8)
  }
}

private extension WatchedMarkView {
  var baseMenus: some View {
    VStack {
      Button(didWatch ? "안 봤어요" : "봤어요") {
        withAnimation {
          conference.toggleWatchedSession(id: sessionID)
          latestWatchedSessionID = sessionID
        }
      }

      Divider()

      Button("최고에요"){
        // Do Something
      }

      Button {
        // Do Something
      } label: {
        Menu("기대돼요", content: { subMenus })
      }
    }
  }

  var subMenus: some View {
    VStack {
      Button("팬이에요") {
        // Do Something
      }
      Button("멋있어요") {
        // Do Something
      }
    }
  }
}

// MARK: - Previews

struct WatchedMarkView_Previews : PreviewProvider {
  static var previews: some View {
    let conf = Conference()
    conf.toggleWatchedSession(id: 1)

    return Group {
      WatchedMarkView(sessionID: 1, latestWatchedSessionID: .constant(nil))
      WatchedMarkView(sessionID: 2, latestWatchedSessionID: .constant(nil))
    }
    .previewLayout(.sizeThatFits)
    .environmentObject(conf)
  }
}

