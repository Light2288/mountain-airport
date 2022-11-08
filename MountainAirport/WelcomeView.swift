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
          .aspectRatio(contentMode: .fill)
          .frame(height: 250)
        if
          let id = appEnvironment.lastFlightId,
          let lastFlight = flightInfo.getFlightById(id) {
          NavigationLink(
            destination: FlightDetails(flight: lastFlight),
            isActive: $showNextFlight
          ) { }
        }
        ScrollView {
          LazyVGrid(
            columns: [GridItem(.fixed(160)), GridItem(.fixed(160))],
            spacing: 15) {
              FlightStatusButton(flightInfo: flightInfo)
              SearchFlightsButton(flightInfo: flightInfo)
              AwardsButton()
              LastViewedButton(
                flightInfo: flightInfo,
                appEnvironment: appEnvironment,
                showNextFlight: $showNextFlight
              )
            }
            .font(.title)
            .foregroundColor(.white)
            .padding()
        }
      }.navigationBarTitle("Mountain Airport")
      // End Navigation View
    }.navigationViewStyle(StackNavigationViewStyle())
      .environmentObject(appEnvironment)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    WelcomeView()
  }
}
