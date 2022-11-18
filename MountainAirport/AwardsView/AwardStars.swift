import SwiftUI

struct AwardStars: View {
  var stars: Int = 3

  var body: some View {
    Canvas { gContext, size in
      // 1
      guard let starSymbol = gContext.resolveSymbol(id: 0) else {
        return
      }

      // 1
      let centerOffset = (size.width - (20 * Double(stars))) / 2.0
      // 2
      gContext.translateBy(x: centerOffset, y: size.height / 2.0)
      // 1
      for star in 0..<stars {
        // 2
        let starXPosition = Double(star) * 20.0
        // 3
        let point = CGPoint(x: starXPosition + 8, y: 0)
        // 4
        gContext.draw(starSymbol, at: point, anchor: .leading)
      }
      // 2
    } symbols: {
      // 3
      Image(systemName: "star.fill")
        .resizable()
        .frame(width: 15, height: 15)
        // 4
        .tag(0)
    }
  }
}

struct AwardStars_Previews: PreviewProvider {
  static var previews: some View {
    AwardStars()
  }
}
