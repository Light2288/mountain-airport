import SwiftUI

struct WelcomeView: View {
  //
  @StateObject var flightInfo = FlightData()
  
  var body: some View {
    NavigationView {
      ZStack(alignment: .topLeading) {
        Image("welcome-background")
          .resizable()
          .frame(height: 250)
        VStack(alignment: .leading) {
          NavigationLink(destination: FlightStatusBoard()) {
            WelcomeButtonView(title: "Flight Status", subTitle: "Departure and arrival information")
          }
          Spacer()
        }
        .font(.title)
        .foregroundColor(.white)
        .padding()
      }
      .navigationTitle("Mountain Airport")
    }
    .navigationViewStyle(.stack)
  }
}
  
  struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      WelcomeView()
    }
  }
