//
//  WatchedSessionView.swift
//  SwiftUILetUsGoExample (iOS)
//
//  Created by Fourenn on 2020/11/21.
//

import SwiftUI

struct WatchedSessionView: View {
  @EnvironmentObject private var conference: Conference
  @Binding var latestWatchedSessionID: Int?
  @Binding var chosenWatchedSessionID: Int?
  
  let sessionNamespace: Namespace.ID
  let watchedNamespace: Namespace.ID

  @State private var animateSessionToWatched = false
  @State private var animateQuake = false

  func matchedSession(id: Int) -> Bool {
    latestWatchedSessionID == id && !animateSessionToWatched
  }

  var body: some View {
    if !conference.watchedSessions.isEmpty {
      VStack(alignment: .leading, spacing: 5) {
        Text("Watched")
          .fontWeight(.medium)
          .offset(x: 3, y: 0)

        HStack {
          speakerImages
        }
      }
    }
  }

  var speakerImages: some View {
    ForEach(conference.watchedSessions.sorted(by: { $0.id < $1.id })) { session in
      Image(session.name)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .modifier(
          WatchedProfileImageModifier(pct: matchedSession(id: session.id) ? 0.0 : 1.0)
        )
        .matchedGeometryEffect(id: session.id, in: watchedNamespace, isSource: true)
        .matchedGeometryEffect(id: matchedSession(id: session.id) ? session.id : -session.id,
                               in: sessionNamespace,
                               isSource: false)
        .offset(x: animateQuake ? .random(in: -20...20) : 0,
                y: animateQuake ? .random(in: -10...10) : 0)
        .frame(height: 80)
        .onAppear(perform: onImageAppear)
        .onTapGesture(count: 2) { toggleWatchedSession(id: session.id) }
        .onTapGesture(count: 1) { chosenWatchedSessionID = session.id }
        .contextMenu {
          Button("Info") { chosenWatchedSessionID = session.id }
          Button("Unwatched") { toggleWatchedSession(id: session.id) }
        }
    }
  }

  func onImageAppear() {
    animateSessionToWatched = false

    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.5)) {
      animateSessionToWatched = true
      animateQuake = true
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
      withAnimation {
        animateQuake = false
      }
    }
  }

  func toggleWatchedSession(id: Int) {
    withAnimation {
      conference.toggleWatchedSession(id: id)
    }
  }
}


// MARK: - WatchedProfileImageModifier

private struct WatchedProfileImageModifier: AnimatableModifier {
  var pct: CGFloat

  var animatableData: CGFloat {
    get { pct }
    set { pct = newValue }
  }

  func body(content: Content) -> some View {
    let cornerRadius = 0.1 + 0.9 * pct
    let insettableCircle = InsettableCircleView(pct: cornerRadius)

    return content
      .clipShape(insettableCircle)
      .overlay(insettableCircle.stroke(Color.white, lineWidth: 2 * pct))
      .padding(4 * pct)
      .overlay(insettableCircle.strokeBorder(Color.black.opacity(0.1 * Double(pct))))
      .shadow(radius: 6)
      .padding(4 * pct)
  }
}
