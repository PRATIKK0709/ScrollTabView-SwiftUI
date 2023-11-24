import SwiftUI
import CoreMotion
import CoreLocation
import AVFoundation
import LocalAuthentication
import CoreBluetooth

@main
struct Test: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}




struct ContentView: View {
    @State private var selectedTabIndex = 0
    
    let tabs = [
        TabItem(title: "Home", icon: "house"),
        TabItem(title: "Explore", icon: "safari"),
        TabItem(title: "Profile", icon: "person"),
        TabItem(title: "Settings", icon: "gear"),
        TabItem(title: "Info", icon: "info.circle")
    ]
    
    var body: some View {
        VStack {
            TabView(selection: $selectedTabIndex) {
                ForEach(0..<tabs.count, id: \.self) { index in
                    Text("Content for \(tabs[index].title)")
                        .tag(index)
                        .font(.title)
                        .foregroundColor(.blue)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(0..<tabs.count, id: \.self) { index in
                        TabButton(tab: tabs[index], isSelected: index == selectedTabIndex) {
                            withAnimation {
                                selectedTabIndex = index
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding(.vertical, 20)
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.gray, Color.black]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TabButton: View {
    let tab: TabItem
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 5) {
                Image(systemName: tab.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundColor(isSelected ? .white : Color.gray.opacity(0.7))
                
                Text(tab.title)
                    .font(.footnote)
                    .foregroundColor(isSelected ? .white : Color.gray.opacity(0.7))
            }
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(isSelected ? Color.blue : Color.clear)
            )
        }
    }
}

struct TabItem: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
}
