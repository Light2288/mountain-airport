import SwiftUI

extension AnyTransition {
    static var buttonNameTransition: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing)
            .combined(with: .opacity)
        let removal = AnyTransition.scale(scale: 0.0)
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}

struct FlightInfoPanel: View {
  var flight: FlightInformation
  @State private var showTerminal = false

  var timeFormatter: DateFormatter {
    let tdf = DateFormatter()
    tdf.timeStyle = .short
    tdf.dateStyle = .none
    return tdf
  }

  var body: some View {
    HStack(alignment: .top) {
      Image(systemName: "info.circle")
        .resizable()
        .frame(width: 35, height: 35, alignment: .leading)
      VStack(alignment: .leading) {
        Text("Flight Details")
          .font(.title2)
        if flight.direction == .arrival {
          Text("Arriving at Gate \(flight.gate)")
          Text("Flying from \(flight.otherAirport)")
        } else {
          Text("Departing from Gate \(flight.gate)")
          Text("Flying to \(flight.otherAirport)")
        }
        Text(flight.flightStatus) + Text(" (\(timeFormatter.string(from: flight.localTime)))")
        Button(action: {
            withAnimation {
                showTerminal.toggle()
            }
        }, label: {
          HStack(alignment: .center) {
              Image(systemName: "airplane.circle")
                .resizable()
                .frame(width: 30, height: 30)
                .padding(10)
                .rotationEffect(.degrees(showTerminal ? 90 : 270))
//                .animation(.linear(duration: 2.0), value: showTerminal)
                .animation(.spring(response: 0.55, dampingFraction: 0.45, blendDuration: 0), value: showTerminal)
              Spacer()
              Group {
                  if showTerminal {
                      Text("Hide terminal map")
                  } else {
                      Text("Show terminal map")
                  }
              }
              .transition(.move(edge: .bottom))
            Spacer()
            Image(systemName: "airplane.circle")
              .resizable()
              .frame(width: 30, height: 30)
              .padding(10)
              .rotationEffect(.degrees(showTerminal ? 90 : 270))
//              .animation(.timingCurve(0.8, 0.3, 0.3, 0.8, duration: 1.0), value: showTerminal)
//              .animation(.linear(duration: 1.0), value: showTerminal)
//              .scaleEffect(showTerminal ? 1.5 : 1.0)
              .animation(.spring(response: 0.55, dampingFraction: 0.45, blendDuration: 0), value: showTerminal)
          }
        })
        if showTerminal {
          FlightTerminalMap(flight: flight)
                .transition(.buttonNameTransition)
        }
        Spacer()
      }
    }
  }
}

struct FlightInfoPanel_Previews: PreviewProvider {
  static var previews: some View {
    FlightInfoPanel(
      flight: FlightData.generateTestFlight(date: Date())
    )
  }
}
