import SwiftUI

struct WelcomeView: View {
  @StateObject var flightInfo = FlightData()
  @State var showNextFlight = false
  @StateObject var appEnvironment = AppEnvironment()

  var body: some View {
    NavigationView {
      ZStack(alignment: .topLeading) {
        Image("welcome-background")
          .resizable()
          .frame(height: 250)
        NavigationLink(
          // swiftlint:disable:next force_unwrapping
          destination: FlightDetails(flight: flightInfo.flights.first!),
          isActive: $showNextFlight
        ) { }
        ScrollView {
          WelcomeAnimation()
            .foregroundColor(.white)
            .frame(height: 40)
            .padding()
          LazyVGrid(
            columns: [
              GridItem(.fixed(160)),
              GridItem(.fixed(160))
            ], spacing: 15
          ) {
            NavigationLink(
              destination: FlightStatusBoard(
                flights: flightInfo.getDaysFlights(Date()))
            ) {
              WelcomeButtonView(
                title: "Flight Status",
                subTitle: "Departure and arrival information",
                imageName: "airplane",
                imageAngle: -45.0
              )
            }
            NavigationLink(
              destination: SearchFlights(
                flightData: flightInfo.flights
              )
            ) {
              WelcomeButtonView(
                title: "Search Flights",
                subTitle: "Search upcoming flights",
                imageName: "magnifyingglass"
              )
            }
            NavigationLink(
              destination: AwardsView()
            ) {
              WelcomeButtonView(
                title: "Your Awards",
                subTitle: "Earn rewards for your airport interactions",
                imageName: "star.fill")
            }
            if
              let id = appEnvironment.lastFlightId,
              let lastFlight = flightInfo.getFlightById(id) {
              // swiftlint:disable multiple_closures_with_trailing_closure
              Button(action: {
                showNextFlight = true
              }) {
                WelcomeButtonView(
                  title: "Last Viewed Flight",
                  subTitle: lastFlight.flightName,
                  imageName: "suit.heart.fill"
                )
              }
              // swiftlint:enable multiple_closures_with_trailing_closure
            }
            Spacer()
          }.font(.title)
          .foregroundColor(.white)
          .padding()
        }
      }.navigationTitle("Mountain Airport")
      // End Navigation View
    }.navigationViewStyle(StackNavigationViewStyle())
    .environmentObject(appEnvironment)
  }
}

struct WelcomeView_Previews: PreviewProvider {
  static var previews: some View {
    WelcomeView()
  }
}
