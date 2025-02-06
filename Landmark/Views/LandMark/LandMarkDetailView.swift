import SwiftUI
import SwiftData

struct LandMarkDetailView: View {
    @State private var VM = LandmarkViewModel()
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var appSetting: AppSettings

    @Query var favoriteItems: [FavoriteItem]
    
    let landmark: Item
    
    var isAlreadyInFavorite: Bool {
        favoriteItems.contains { $0.contentid == landmark.contentid }
    }
    
    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string: VM.detailLandmark.firstimage ?? ""), scale: 1) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.55)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 0.6)
                    .cornerRadius(10)
            }
            
            VStack(alignment: .leading, spacing: 15) {
                Text(VM.detailLandmark.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding([.top, .horizontal])
                
                HStack {
                    Text(VM.detailLandmark.tel ?? "전화번호 없음")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding([.horizontal])
                
                Divider()
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundStyle(.black)
                        Text("주소")
                            .font(.headline)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    
                    Text(VM.detailLandmark.addr1)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(3)
                    
                    Divider()
                }
                .padding([.horizontal, .top])
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("About")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text(VM.detailLandmark.overview ?? "상세 정보 없음")
                        .font(.body)
                        .foregroundColor(.gray)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding([.horizontal])
                
                // Like Button
                Button {
                    addToFavorite()
                } label: {
                    Text(isAlreadyInFavorite ? "이미 넣었다 아이가" : "자...드가자")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isAlreadyInFavorite ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(color: isAlreadyInFavorite ? Color.gray.opacity(0.3) : Color.blue.opacity(0.3), radius: 6, x: 0, y: 4)
                }
                .disabled(isAlreadyInFavorite)
                .padding([.horizontal, .bottom])
            }
            .padding([.horizontal])
        }
        .onAppear {
            Task {
                await VM.fetchDetailLandmark(id: landmark.contentid)
                appSetting.coordinate = VM.detailLandmark.locationCoordinate
            }
        }
        .navigationTitle(landmark.title)
        .navigationBarTitleDisplayMode(.automatic)
    }
    
    func addToFavorite() {
        guard !isAlreadyInFavorite else { return }
        
        let saveModel = FavoriteItem(
            contentid: landmark.contentid,
            title: landmark.title,
            latitude: landmark.mapy,
            longitude: landmark.mapx,
            imgURL: landmark.firstimage!,
            address: landmark.addr1
        )
        
        modelContext.insert(saveModel)
    }
}
