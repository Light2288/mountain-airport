import SwiftUI

struct WelcomeView: View {
  enum Dest: Hashable {
    case allFlights, lastFlight
  }
  
  @StateObject var flightInfo = FlightData()
  @State private var path: [Dest] = []
  @StateObject var lastFlightInfo = FlightNavigationInfo()
  
  var body: some View {
    NavigationStack(path: $path) {
      ZStack(alignment: .topLeading) {
        Image("welcome-background")
          .resizable()
          .frame(height: 250)
        VStack(alignment: .leading) {
          NavigationLink(value: Dest.allFlights) {
            WelcomeButtonView(title: "Flight Status", subTitle: "Departure and arrival information")
          }
          NavigationLink(value: Dest.lastFlight) {
            if let id = lastFlightInfo.lastFlightId,
               let lastFlight = flightInfo.getFlightById(id) {
              WelcomeButtonView(title: "Last Flight: \(lastFlight.flightName)", subTitle: "Show next flight departing or arriving at airport")
            }
          }
          Spacer()
        }
        .navigationDestination(for: Dest.self, destination: {
          switch $0 {
          case .allFlights: FlightStatusBoard(flights: flightInfo.getDaysFlights(Date()))
          case .lastFlight:
            if let id = lastFlightInfo.lastFlightId,
               let lastFlight = flightInfo.getFlightById(id) {
              FlightDetails(flight: lastFlight)
            }
          }
        })
        .font(.title)
        .foregroundColor(.white)
        .padding()
      }
      .navigationTitle("Mountain Airport")
    }
    .navigationViewStyle(.stack)
    .environmentObject(lastFlightInfo)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    WelcomeView()
  }
}
