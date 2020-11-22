//
//  DropZone.swift
//  SwiftUILetUsGoExample (macOS)
//
//  Created by Fourenn on 2020/11/21.
//

import SwiftUI
import UniformTypeIdentifiers

struct DropZone: View {
  @State private var isTargeted = false
  @State private var image: NSImage? = nil

  var body: some View {
    Rectangle()
      .fill(isTargeted ? Color.green : Color.secondary)
      .overlay(Text("Drop Zone").font(.largeTitle))
      .overlay(Image(nsImage: image ?? NSImage()).resizable().scaledToFit())
      .onDrop(of: [.fileURL], isTargeted: $isTargeted, perform: onDrop(items:))
  }

  func onDrop(items: [NSItemProvider]) -> Bool {
    guard let item = items.first else { return false }

    item.loadItem(forTypeIdentifier: UTType.fileURL.identifier) { data, _ in
      if let urlData = data as? Data,
         let url = URL(dataRepresentation: urlData, relativeTo: nil) {
        image = NSImage(byReferencing: url)
      }
    }
    return true
  }
}

