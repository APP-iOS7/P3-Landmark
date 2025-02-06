//
//  LandmarkListView.swift
//  Landmark
//
//  Created by 최범수 on 2025-02-05.
//

import SwiftUI
import MapKit

struct LandmarkListView: View {
    @State private var showingSheet = false
    
    var body: some View {
        ZStack {
            MapView(coordinate: CLLocationCoordinate2D(latitude: 37.555946
, longitude: 126.972317))
                .gesture(DragGesture())
            
            
                .sheet(isPresented: $showingSheet) {
                LandmarkListTest()
                        .presentationBackgroundInteraction(.enabled)
                        .presentationDetents([.fraction(0.3), .fraction(0.5), .fraction(1)])
                        .cornerRadius(20)
                        .shadow(radius: 5)
                        .transition(.move(edge: .bottom))
                        .animation(.spring(), value: showingSheet)
                        .interactiveDismissDisabled(true)
                        .background(.clear)
                        .edgesIgnoringSafeArea(.bottom)
            }
        }
    
        
        .onAppear {
            showingSheet = true
        }
    }
}


#Preview {
    LandmarkListView()
}
