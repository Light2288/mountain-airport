import SwiftUI

struct SearchResultRow: View {
  var flight: FlightInformation
  @State private var isPresented = false

  var body: some View {
    Button(
      action: {
        isPresented.toggle()
      }, label: {
        FlightSearchSummary(flight: flight)
      })
      .sheet(
        isPresented: $isPresented,
        onDismiss: {
          print("Modal dismissed. State now: \(isPresented)")
        },
        content: {
          FlightSearchDetails(
            flight: flight,
            showModal: $isPresented
          )
        }
      )
  }
}

struct SearchResultRow_Previews: PreviewProvider {
  static var previews: some View {
    SearchResultRow(
      flight: FlightData.generateTestFlight(date: Date())
    ).environmentObject(AppEnvironment())
  }
}
