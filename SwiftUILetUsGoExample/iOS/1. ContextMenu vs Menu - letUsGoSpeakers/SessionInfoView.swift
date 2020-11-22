//
//  SessionInfoView.swift
//  SwiftUILetUsGoExample (iOS)
//
//  Created by Fourenn on 2020/11/21.
//

import SwiftUI

struct SessionInfoView: View {
  let id: Int
  var pct: CGFloat
  let onClose: () -> ()

  var body: some View {
    EmptyView()
      .modifier(SessionInfoModifier(id: id, pct: pct, onClose: onClose))
  }
}

private struct SessionInfoModifier: AnimatableModifier {
  @EnvironmentObject var conference: Conference

  let id: Int
  var pct: CGFloat
  let onClose: () -> ()

  var animatableData: CGFloat {
    get { pct }
    set { pct = newValue }
  }
  var session: Session {
    conference.sessions.first { $0.id == id }!
  }
  var isWatched: Bool {
    conference.isWatchedSession(id: session.id)
  }

  func body(content: Content) -> some View {
    let cornerRadius = 1 - 0.85 * pct
    let insettableCircle = InsettableCircleView(pct: cornerRadius)

    return GeometryReader { geometry in
      contents(geometry: geometry)
    }
    .padding(24 * pct)
    .overlay(closeButton.opacity(Double(pct)), alignment: .topTrailing)
    .background(BlurView())
    .clipShape(insettableCircle)
    .contentShape(insettableCircle)
    .shadow(radius: 6)
  }

  func contents(geometry: GeometryProxy) -> some View {
    VStack(spacing: 0) {
      speakerProfile(geometry: geometry)

      Divider()
        .padding(.vertical)

      sessionDescription(title: "주제", content: session.title)
      sessionDescription(title: "한 마디", content: session.comment)

      Spacer()

      footer
    }
  }
}

private extension SessionInfoModifier {
  func speakerProfile(geometry: GeometryProxy) -> some View {
    VStack(spacing: 0) {
      speakerImage(geometry: geometry)

      HStack(alignment: .firstTextBaseline) {
        Text(session.name)
          .font(.title2).fontWeight(.heavy)
          .foregroundColor(Color(UIColor.label))

        Text(session.time)
          .font(.callout).fontWeight(.bold)
          .foregroundColor(.secondary)

        Spacer()

        WatchedMarkView(sessionID: id, latestWatchedSessionID: .constant(nil))
      }
      .padding(.top, 8  * pct)
      .opacity(Double(pct))
    }
  }

  func speakerImage(geometry: GeometryProxy) -> some View {
    let imageSize = (1.2 - 0.5 * pct) * geometry.size.width

    return Image(session.name)
      .resizable()
      .aspectRatio(contentMode: .fit)
      .clipShape(Circle())
      .overlay(Circle().stroke(Color.white, lineWidth: 2))
      .padding(4 * pct)
      .overlay(Circle().strokeBorder(Color.black.opacity(0.1)))
      .shadow(radius: 4)
      .frame(width: imageSize, height: imageSize)
      .padding(.bottom, 8  * pct)
      .contextMenu {
        Button(isWatched ? "안 봤어요" : "봤어요") {
          withAnimation { conference.toggleWatchedSession(id: session.id) }
        }
      }
  }

  func sessionDescription(title: String, content: String) -> some View {
    VStack(alignment: .leading) {
      Text(title)
        .font(.title3)
        .fontWeight(.heavy)
        .foregroundColor(Color.black)
        .padding(.bottom, 2)

      Text(content)
        .font(.body)
        .foregroundColor(Color.black.opacity(0.8))

      HStack {
        Spacer()
      }
    }
    .padding(.bottom, 24)
  }

  var footer: some View {
    HStack(spacing: 0) {
      Spacer()
      Text("let us: Go!").fontWeight(.black)
    }
    .font(.caption)
    .foregroundColor(.secondary)
    .opacity(Double(pct))
  }

  var closeButton: some View {
    Image(systemName: "xmark.circle.fill")
      .font(.title)
      .foregroundColor(.secondary)
      .padding(30)
      .onTapGesture(perform: onClose)
  }
}
