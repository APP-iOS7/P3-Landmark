//
//  FavoriteDataModel.swift
//  Landmark
//
//  Created by 최범수 on 2025-02-06.
//

import Foundation
import SwiftUI
import SwiftData
import UIKit


@Model
final class FavoriteItem {
    @Attribute(.unique)
    var contentid: String
    var title: String
    var latitude: String
    var longitude: String
    var imgURL: String
    var address: String
    var isDone: Bool = false
    @Attribute(.externalStorage)
    var image: Data?
    var initDate: Date = Date()
    @Relationship(deleteRule: .cascade, inverse: \Detail.favoriteItem)
    var detail: Detail?
    
    init(contentid: String, title: String, latitude: String, longitude: String, imgURL: String, address: String) {
        self.contentid = contentid
        self.title = title
        self.latitude = latitude
        self.longitude = longitude
        self.imgURL = imgURL
        self.address = address
    }
    
    func addImage(_ imageURL: String) async {
        guard let url = URL(string: imageURL) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            self.image = data
        } catch {
            print("이미지 다운로드 실패: \(error)")
        }
    }


    func getImage() -> Image? {
        guard let imageData = image, let uiImage = UIImage(data: imageData) else {
            return nil
        }
        return Image(uiImage: uiImage)
    }

    
}

@Model
final class Detail {
    var favoriteItem: FavoriteItem?
    var content: String = ""
    var visitDate: Date = Date()
    var rating: Int?
    
    @Attribute(.externalStorage)
    var images: [Data] = []

    init(favoriteItem: FavoriteItem? = nil, content: String = "", visitDate: Date = Date(), rating: Int? = nil, images: [Data] = []) {
        self.favoriteItem = favoriteItem
        self.content = content
        self.visitDate = visitDate
        self.rating = rating
        self.images = images
    }

    func addImage(_ image: UIImage) {
        if let imageData = image.jpegData(compressionQuality: 1) {
            images.append(imageData)
        }
    }

    func getImages() -> [UIImage] {
        return images.compactMap { UIImage(data: $0) }
    }
}
