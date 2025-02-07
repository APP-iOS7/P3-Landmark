import SwiftUI
import PhotosUI
import SwiftData

struct FavoriteDetailView: View {
    let favoriteItem: FavoriteItem
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss

    @State private var content: String = ""
    @State private var visitDate: Date = Date()
    @State private var rating: Int?
    @State private var images: [UIImage] = []
    @State private var selectedItem: PhotosPickerItem? = nil
    
    var body: some View {
        VStack {
            
            ScrollView(.horizontal) {
                LazyHGrid(rows: [GridItem(.fixed(250))], spacing: 10) {
                    ForEach(images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .shadow(radius: 5)
                    }
                    
                    MapView(coordinate: .init(latitude: Double(favoriteItem.latitude)!, longitude: Double(favoriteItem.longitude)!))
                        .frame(width: 250, height: 250)
                }
                .padding(.horizontal)
            }
            
            PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                HStack {
                    Image(systemName: "photo.on.rectangle.angled")
                    Text("사진 추가")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(8)
            }
            .onChange(of: selectedItem) { _, newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        images.append(uiImage)
                    }
                }
            }
            .padding(.bottom, 10)
            
            Form {
                Section {
                    DatePicker("날짜", selection: $visitDate, displayedComponents: .date)
                    
                    Picker("평점", selection: $rating) {
                        Text("선택하세요").tag(nil as Int?)
                        ForEach(Rating.allCases, id: \.self) { rate in
                            Text(rate.stringRating).tag(rate.rawValue as Int?)
                        }
                    }
                }
                
                Section("한줄평") {
                    HStack {
                        TextField("한줄평을 입력하세요", text: $content)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .transition(.opacity)
                    }
                }
                
                Section {
                    Button("저장하기") {
                        saveDetail()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
        }
        .navigationTitle(favoriteItem.title)
        .onAppear {
            loadDetailData()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    dismiss()
                    modelContext.delete(favoriteItem)
                    try? modelContext.save()
                } label: {
                    Image(systemName: "trash")
                        .foregroundStyle(.red)
                }
                
            }
        }
        
    }
    
    private func loadDetailData() {
        if let detail = favoriteItem.detail {
            content = detail.content
            visitDate = detail.visitDate
            rating = detail.rating
            images = detail.getImages()
        }
    }
    
    private func saveDetail() {
        let detail = favoriteItem.detail ?? Detail()
        
        detail.content = content
        detail.visitDate = visitDate
        detail.rating = rating
        detail.images = images.compactMap { $0.jpegData(compressionQuality: 1) }
        
        if favoriteItem.detail == nil {
            favoriteItem.detail = detail
        }
        
        modelContext.insert(favoriteItem)
    }
}

enum Rating: Int, CaseIterable, Identifiable {
    case zero, one, two, three, four, five
    
    var id: Int { rawValue }
    
    var stringRating: String {
        switch self {
        case .zero: return "💩"
        case .one: return "⭐️"
        case .two: return "⭐⭐"
        case .three: return "⭐⭐⭐"
        case .four: return "⭐⭐⭐⭐"
        case .five: return "⭐⭐⭐⭐⭐"
        }
    }
}
