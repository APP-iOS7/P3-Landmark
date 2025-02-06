import SwiftUI


struct ContentView: View {
    @EnvironmentObject var appSetting: AppSettings
    var body: some View {
        ZStack {
            TabView(selection: $appSetting.tab) {
                LandmarkMapView()
                    .tag(0)
                FavoriteView()
                    .tag(1)
                MypageView()
                    .tag(2)
            }
            .toolbar(.hidden, for: .tabBar)
            VStack {
                Spacer()
                FloatingTabBar(selectedTab: $appSetting.tab)
            }
        }
    }
}

struct FloatingTabBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack {
            Spacer()
            TabButton(icon: "magnifyingglass", index: 0, selectedTab: $selectedTab)
            Spacer()
            TabButton(icon: "heart.fill", index: 1, selectedTab: $selectedTab)
            Spacer()
            TabButton(icon: "person.fill", index: 2, selectedTab: $selectedTab)
            Spacer()
        }
        .frame(height: 70)
        .background(Color.white)
        .cornerRadius(35)
        .shadow(radius: 10)
        .padding(.horizontal, 20)
    }
}

struct TabButton: View {
    let icon: String
    let index: Int
    @Binding var selectedTab: Int
    @EnvironmentObject var appSetting: AppSettings
    
    var body: some View {
        Button(action: {
            selectedTab = index
            if selectedTab == 0 {
                appSetting.showingSheet = true
            } else {
                appSetting.showingSheet = false
            }
        }) {
            Image(systemName: icon)
                .font(.system(size: 25))
                .foregroundColor(selectedTab == index ? .blue : .gray)
        }
    }
}
#Preview {
    ContentView()
        .environmentObject(AppSettings())
}
