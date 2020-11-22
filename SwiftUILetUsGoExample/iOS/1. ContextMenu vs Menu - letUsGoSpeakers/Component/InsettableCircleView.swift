//
//  InsettableCircleView.swift
//  SwiftUILetUsGoExample (iOS)
//
//  Created by Fourenn on 2020/11/21.
//

import SwiftUI

struct InsettableCircleView: InsettableShape {
  var pct: CGFloat
  var amount: CGFloat = 0

  func path(in rect: CGRect) -> Path {
    let insetRect = CGRect(
      x: rect.minX + amount,
      y: rect.minY + amount,
      width: rect.width - (amount * 2),
      height: rect.height - (amount * 2)
    )
    
    return Path(roundedRect: insetRect, cornerRadius: insetRect.width / 2.0 * pct)
  }

  func inset(by amount: CGFloat) -> some InsettableShape {
    var copy = self
    copy.amount += amount
    return copy
  }
}
