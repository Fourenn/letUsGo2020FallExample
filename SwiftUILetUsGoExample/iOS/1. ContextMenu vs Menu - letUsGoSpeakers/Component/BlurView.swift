//
//  BlurView.swift
//  SwiftUILetUsGoExample (iOS)
//
//  Created by Fourenn on 2020/11/21.
//

import SwiftUI

struct BlurView: View {
  @Environment(\.colorScheme) var scheme
  var onTapGesture: (() -> ())?

  var body: some View {
    Representable(effect: UIBlurEffect(style: blurEffectStyle))
      .ignoresSafeArea()
      .onTapGesture(perform: onTapGesture ?? {})
  }

  var blurEffectStyle: UIBlurEffect.Style {
    scheme == .dark
      ? .systemUltraThinMaterialDark
      : .systemUltraThinMaterialLight
  }
}

// MARK: - Representable

private extension BlurView {
  struct Representable: UIViewRepresentable {
    let effect: UIVisualEffect

    func makeUIView(context: Context) -> UIView {
      return UIVisualEffectView(effect: effect)
    }
    
    func updateUIView(_ rootView: UIView, context: Context) {
    }
  }
}
