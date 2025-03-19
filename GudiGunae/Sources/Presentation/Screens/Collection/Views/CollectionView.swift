struct CollectionView: View {
    @EnvironmentObject var coordinator: TabBarCoordinator
    @StateObject var viewModel: CollectionViewModel
    @ObservedObject var mapViewModel: MapViewModel
    
    @State private var showShareSheet = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.filteredRestaurants) { restaurant in
                        CollectionCellView(
                            mapViewModel: mapViewModel,
                            viewModel: CollectionCellViewModel(restaurant: restaurant)
                        )
                        .environmentObject(coordinator)
                        .onTapGesture {
                            viewModel.selectedRestaurant = restaurant
                            showDetailImage = true
                        }
                    }
                }
                .padding()
            }
            .background(Color.gray.opacity(0.2))
            .navigationTitle("모아보기")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showShareSheet = true
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                    .disabled(viewModel.selectedRestaurants.isEmpty)
                }
            }
        }
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(activityItems: createShareItems())
        }
        .onAppear {
            Task {
                await viewModel.fetchRestaurants()
            }
        }
        .refreshable {
            Task {
                await viewModel.fetchRestaurants()
            }
        }
    }
    
    private func createShareItems() -> [Any] {
        let selectedRestaurants = viewModel.selectedRestaurants
        
        // 공유할 텍스트 생성
        var shareText = "구디구내 맛집 리스트\n\n"
        
        for restaurant in selectedRestaurants {
            shareText += "📍 \(restaurant.name)\n"
            shareText += "   주소: \(restaurant.address)\n\n"
        }
        
        return [shareText]
    }
}

// UIKit의 ActivityViewController를 SwiftUI에서 사용하기 위한 래퍼
struct ShareSheet: UIViewControllerRepresentable {
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: nil
        )
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
} 