//
//  FavoriteDataModel.swift
//  Landmark
//
//  Created by 최범수 on 2025-02-06.
//

import Foundation
import SwiftData

@Model
final class FavoriteStore {
    var favoriteLandmarks: [FavoriteItem] = []
    init() { }
    
}

@Model
class FavoriteItem {
    var contentid: String
    var title: String
    var addr1: String
    var tel: String?
    var firstimage: String?
    var overview: String?
    var mapx: String
    var mapy: String

    init(from item: Item) {
        self.contentid = item.contentid
        self.title = item.title
        self.addr1 = item.addr1
        self.tel = item.tel
        self.firstimage = item.firstimage
        self.overview = item.overview
        self.mapx = item.mapx
        self.mapy = item.mapy
    }
}
