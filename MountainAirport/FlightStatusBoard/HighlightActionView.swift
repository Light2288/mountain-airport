import SwiftUI

struct HighlightActionView: View {
  var flightId: Int
  @Binding var highlightedIds: [Int]

  func toggleHighlight() {
    // 1
    let flightIdx = highlightedIds.firstIndex { $0 == flightId
    }
    // 2
    if let index = flightIdx {
      // 3
      highlightedIds.remove(at: index)
    } else {
      // 4
      highlightedIds.append(flightId)
    }
  }

  var body: some View {
    Button {
      toggleHighlight()
    } label: {
      Image(systemName: "highlighter")
    }
    .tint(Color.yellow)
  }
}

struct HighlightActionView_Previews: PreviewProvider {
  static var previews: some View {
    HighlightActionView(
      flightId: 1,
      highlightedIds: .constant([1])
    )
  }
}
