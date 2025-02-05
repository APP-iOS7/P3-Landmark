//
//  APIManager.swift
//  Landmark
//
//  Created by 최범수 on 2025-02-05.
//

import Foundation

struct APIManager {
    static var shared = APIManager()
    private init() {}
    
    let apiKey: String = "%2BvcMcBET7XUICc71eswmUPA%2BKKcjXgNGMw8ryEDDKS4RfZmEpXiyW8T58gupWI0KCNOjeYnBIMoCcF4O1KYBSg%3D%3D"
    let numOfRows: Int = 30
    var keyword: String = ""
    var encodedKeyword: String {
        keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    
    var searchURL: String { "https://apis.data.go.kr/B551011/KorService1/searchKeyword1?serviceKey=\(apiKey)&numOfRows=\(numOfRows)&pageNo=1&MobileOS=IOS&MobileApp=AppTest&_type=json&listYN=Y&arrange=C&keyword=\(encodedKeyword)"
    }
    
    func fetchSearchData() async throws -> [Item] {
        guard let requestURL = URL(string: searchURL) else {
            throw NSError(domain: "Invalid URL", code: 400, userInfo: nil)
        }

        let (data, _) = try await URLSession.shared.data(from: requestURL)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase // 스네이크 케이스 변환

        do {
            let decodedData = try decoder.decode(APIResponse.self, from: data)
            let items = decodedData.response.body.items.item
            return items
        } catch {
            print("디코딩 오류: \(error)")
            throw error
        }
    }
    
//    func fetchDetailData(for item: Item) async throws -> DetailResponse {
//        
//    }
}

