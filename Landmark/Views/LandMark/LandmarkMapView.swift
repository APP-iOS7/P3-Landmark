//
//  LandmarkListView.swift
//  Landmark
//
//  Created by 최범수 on 2025-02-05.
//

import SwiftUI
import MapKit

struct LandmarkMapView: View {
    @EnvironmentObject var appSetting: AppSettings
    @State var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    var body: some View {
        VStack {
            MapView(coordinate: appSetting.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.0010, longitudeDelta: 0.0010))
            .gesture(DragGesture())
            .sheet(isPresented: $appSetting.showingSheet) {
                LandmarkModalListView()
                    .presentationBackgroundInteraction(.enabled)
                    .presentationDetents([.fraction(0.2), .fraction(0.5), .fraction(1)])
                    .cornerRadius(20)
                    .shadow(radius: 5)
                    .transition(.move(edge: .bottom))
                    .animation(.spring(), value: appSetting.showingSheet)
                    .interactiveDismissDisabled(true)
                    .background(.clear)
                    .edgesIgnoringSafeArea(.bottom)
            }
        }
        .onAppear {
            appSetting.showingSheet = true
        }
    }
}


#Preview {
    LandmarkMapView()
        .environmentObject(AppSettings())
}
