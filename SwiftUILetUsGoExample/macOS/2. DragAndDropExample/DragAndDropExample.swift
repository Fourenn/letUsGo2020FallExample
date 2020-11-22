//
//  DragAndDropExample.swift
//  DeprecatedAPIsExample
//
//  Created by Fourenn on 2020/10/30.
//

import SwiftUI
import UniformTypeIdentifiers

struct DragAndDropExample: View {
  var body: some View {
    VStack {
      ImageDroppableView()

      Divider().padding()

      DropZone()
    }
    .padding()
  }
}

// MARK: - Previews

struct DragAndDropExample_Previews: PreviewProvider {
  static var previews: some View {
    DragAndDropExample()
      .frame(width: 400, height: 600)
  }
}
