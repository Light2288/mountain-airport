import SwiftUI

struct FlightDetails: View {
  var flight: FlightInformation
    @EnvironmentObject var lastFlightInfo: FlightNavigationInfo

  var body: some View {
    ZStack {
      Image("background-view")
        .resizable()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      VStack(alignment: .leading) {
        HStack {
          FlightDirectionGraphic(direction: flight.direction)
            .frame(width: 40, height: 40)
          VStack(alignment: .leading) {
            Text("\(flight.dirString) \(flight.otherAirport)")
            Text(flight.flightStatus)
              .font(.subheadline)
          }.font(.title2)
        }
        Spacer()
      }.foregroundColor(.white)
      .padding()
      .navigationTitle("\(flight.airline) Flight \(flight.number)")
    }
    .onAppear {
        lastFlightInfo.lastFlightId = flight.id
    }
  }
}

struct FlightDetails_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      FlightDetails(
        flight: FlightData.generateTestFlight(date: Date())
      )
      .environmentObject(FlightNavigationInfo())
    }
  }
}
