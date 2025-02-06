//
//  FavoriteDataModel.swift
//  Landmark
//
//  Created by 최범수 on 2025-02-06.
//

import Foundation
import SwiftData


@Model
class FavoriteItem {
    var contentid: String
    var title: String

    init(contentid: String, title: String) {
        self.contentid = contentid
        self.title = title
    }
}
