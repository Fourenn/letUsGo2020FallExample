//
//  ConferenceHome.swift
//  SwiftUILetUsGoExample (iOS)
//
//  Created by Fourenn on 2020/11/21.
//

import SwiftUI

struct ConferenceHome: View {
  @EnvironmentObject private var conference: Conference

  @State private var chosenMainSessionID: Int? = nil
  @State private var chosenWatchedSessionID: Int? = nil
  @State private var latestWatchedSessionID: Int? = nil
  @State private var blur: Bool = false

  @Namespace private var sessionNamespace
  @Namespace private var watchedNamespace

  @State private var animateImageToInfo: Bool = false
  var matchedSessionToInfo: Bool {
    !animateImageToInfo && chosenMainSessionID != nil
  }
  var matchedWatchedToInfo: Bool {
    !animateImageToInfo && chosenWatchedSessionID != nil
  }

  var body: some View {
    ZStack {
      mainContents

      if let sessionID = chosenMainSessionID ?? chosenWatchedSessionID {
        sessionInfo(id: sessionID)
          .background(BlurView(onTapGesture: dismissSessionInfo))
          .zIndex(1.0)
      }
    }
  }
}

private extension ConferenceHome {
  var mainContents: some View {
    VStack(alignment: .leading) {
      titleView
        .frame(height: 60)
        .padding(.top, 16)

      Divider()
        .padding(.bottom, 10)

      sessionsScrollView

      watchedSession
    }
    .padding(.horizontal)
  }

  var titleView: some View {
    let gradient = Gradient(colors: [.orange, .yellow, .green, .blue])
    let gradientTitle = LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .trailing)
        .mask(Text("let us: Go!").font(.largeTitle).fontWeight(.bold))

    return VStack(alignment: .leading, spacing: 4) {
      Text("let us: Go!")
        .foregroundColor(.clear)
        .font(.largeTitle).fontWeight(.bold)
        .overlay(gradientTitle)

      Text("2020 fall")
        .font(.subheadline)
        .foregroundColor(.secondary)
    }
  }

  var sessionsScrollView: some View {
    ScrollView(showsIndicators: false) {
      LazyVGrid(columns: [.init(.adaptive(minimum: 160), spacing: 20)]) {
        ForEach(conference.sessions) { session in
          Image(session.name)
            .resizable()
            .scaledToFill()
            .cornerRadius(10)
            .overlay(WatchedMarkView(sessionID: session.id, latestWatchedSessionID: $latestWatchedSessionID),
                     alignment: .topTrailing)
            .matchedGeometryEffect(id: session.id, in: sessionNamespace, isSource: true)
            .onTapGesture(count: 2) { toggleWatchedSession(id: session.id) }
            .onTapGesture(count: 1) { chosenMainSessionID = session.id }
            .contextMenu {
              Button("Info") { chosenMainSessionID = session.id }
              Button(session.isWatched ? "안 봤어요" : "봤어요") {
                toggleWatchedSession(id: session.id)
              }
            }
        }
      }
    }
  }

  var watchedSession: some View {
    WatchedSessionView(
      latestWatchedSessionID: $latestWatchedSessionID,
      chosenWatchedSessionID: $chosenWatchedSessionID,
      sessionNamespace: sessionNamespace,
      watchedNamespace: watchedNamespace
    )
    .padding(.top, 2)
  }

  
  func sessionInfo(id: Int) -> some View {
    SessionInfoView(id: id, pct: animateImageToInfo ? 1 : 0, onClose: dismissSessionInfo)
      .padding(32)
      .padding(.vertical, 32)
      .matchedGeometryEffect(id: matchedSessionToInfo ? id : 0, in: sessionNamespace, isSource: false)
      .matchedGeometryEffect(id: matchedWatchedToInfo ? id : 0, in: watchedNamespace, isSource: false)
      .onAppear {
        withAnimation(.spring(response: 0.6, dampingFraction: 0.55)) {
          animateImageToInfo = true
        }
      }
      .onDisappear { animateImageToInfo = false }
      .transition(
        AnyTransition.asymmetric(
          insertion: .identity,
          removal: AnyTransition.scale.combined(with: .opacity)
        )
      )
  }

  func toggleWatchedSession(id: Int) {
    if !conference.isWatchedSession(id: id) {
      latestWatchedSessionID = id
    }
    withAnimation {
      conference.toggleWatchedSession(id: id)
    }
  }

  func dismissSessionInfo() {
    withAnimation {
      chosenMainSessionID = nil
      chosenWatchedSessionID = nil
      blur = false
    }
  }
}

// MARK: - Previews

struct ConferenceHome_Previews : PreviewProvider {
  static var previews: some View {
    ConferenceHome()
      .environmentObject(Conference())
  }
}
