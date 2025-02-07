//
//  MapView.swift
//  Landmark
//
//  Created by 최범수 on 2025-02-05.
//

import SwiftUI
import MapKit

struct MapView: View {
    var coordinate: CLLocationCoordinate2D
    var span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
    
    var body: some View {
        Map(position: .constant(.region(region)))
    }

    private var region: MKCoordinateRegion {
        MKCoordinateRegion(
            center: coordinate,
            span: span
        )
    }
}
