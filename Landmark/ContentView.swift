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


#Preview {
    ContentView()
        .environmentObject(AppSettings())
}
