import SwiftUI

struct AwardDetails: View {
  var award: AwardInformation

  func imageSize(proxy: GeometryProxy) -> CGFloat {
    let size = min(proxy.size.width, proxy.size.height)
    return size * 0.8
  }

  var body: some View {
    VStack(alignment: .center) {
      Image(award.imageName)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .padding()
      Text(award.title)
        .font(.title)
        .padding()
      Text(award.description)
        .font(.body)
        .padding()
      Spacer()
    }.padding()
    .opacity(award.awarded ? 1.0 : 0.4)
    .saturation(award.awarded ? 1 : 0)
  }
}

struct AwardDetails_Previews: PreviewProvider {
  static var previews: some View {
    let award = AwardInformation(
      imageName: "first-visit-award",
      title: "First Visit",
      description: "Awarded the first time you open the app while at the airport.",
      awarded: true
    )

    let award2 = AwardInformation(
      imageName: "rainy-day-award",
      title: "Rainy Day",
      description: "Your flight was delayed because of weather.",
      awarded: false
    )

    Group {
      AwardDetails(award: award)
      AwardDetails(award: award2)
    }
  }
}
