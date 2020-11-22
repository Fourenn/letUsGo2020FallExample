//
//  ImageDroppableView.swift
//  SwiftUILetUsGoExample (macOS)
//
//  Created by Fourenn on 2020/11/21.
//

import SwiftUI

struct ImageDroppableView: View {
  let cats = ["cat1", "cat2"]
  let dogs = ["dog1", "dog2"]

  var body: some View {
    VStack {
      animalImages(for: cats)
      animalImages(for: dogs)
    }
  }

  func animalImages(`for` imageNames: [String]) -> some View {
    HStack {
      ForEach(imageNames, id: \.self) { imageName in
        draggableImage(name: imageName)
      }
    }
  }

  func draggableImage(name: String) -> some View {
    let imageURL = Bundle.main.url(forResource: name, withExtension: "jpg")!

    return Image(nsImage: NSImage(byReferencing: imageURL))
      .resizable()
      .aspectRatio(3/2, contentMode: .fit)
      .cornerRadius(16)
      .onDrag { NSItemProvider(object: imageURL as NSURL) }
  }
}

// MARK: - Previews

struct ImageDroppableView_Previews: PreviewProvider {
  static var previews: some View {
    ImageDroppableView()
      .frame(width: 400, height: 300)
  }
}
