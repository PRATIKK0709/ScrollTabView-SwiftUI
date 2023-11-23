import SwiftUI
import CoreMotion
import CoreLocation
import AVFoundation
import LocalAuthentication
import CoreBluetooth

@main
struct SensorTestApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @State private var selectedTabIndex = 0
    
    let tabs = ["Tab 1", "Tab 2", "Tab 3", "Tab 4", "Tab 5"]
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(0..<tabs.count, id: \.self) { index in
                        Text(tabs[index])
                            .font(.headline)
                            .padding(10)
                            .foregroundColor(.white)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(
                                        index == selectedTabIndex ? Color.blue : Color.gray
                                    )
                            )
                            .onTapGesture {
                                withAnimation {
                                    selectedTabIndex = index
                                }
                            }
                    }
                }
                .padding(.horizontal, 20)
            }
            
            TabView(selection: $selectedTabIndex) {
                ForEach(0..<tabs.count, id: \.self) { index in
                    Text("Content for \(tabs[index])")
                        .tag(index)
                        .font(.title)
                        .foregroundColor(.blue)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .padding(.vertical, 20)
        .background(LinearGradient(gradient: Gradient(colors: [Color.gray, Color.black]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
