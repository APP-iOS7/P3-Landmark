//
//  FavoriteDataModel.swift
//  Landmark
//
//  Created by 최범수 on 2025-02-06.
//

import Foundation
import SwiftData


@Model
final class FavoriteItem {
    var contentid: String
    var title: String
    var latitude: String
    var longitude: String
    var imgURL: String
    var address: String
    var isDone: Bool = false
    var initDate: Date = Date()
    
    init(contentid: String, title: String, latitude: String, longitude: String, imgURL: String, address: String) {
        self.contentid = contentid
        self.title = title
        self.latitude = latitude
        self.longitude = longitude
        self.imgURL = imgURL
        self.address = address
    }
}
