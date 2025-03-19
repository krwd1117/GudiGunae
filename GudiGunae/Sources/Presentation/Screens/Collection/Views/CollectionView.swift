struct CollectionView: View {
    @ObservedObject var coordinator: CollectionTabCoordinator
    @StateObject var viewModel: CollectionViewModel = CollectionViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.filteredRestaurants) { restaurant in
                        CollectionCellView(viewModel: CollectionCellViewModel(restaurant: restaurant))
                            .onTapGesture {
                                // TabBar의 MapTabCoordinator를 통해 맵 뷰로 이동
                                if let tabBarCoordinator = coordinator.parent as? TabBarCoordinator,
                                   let mapCoordinator = tabBarCoordinator.mapTabCoordinator {
                                    mapCoordinator.navigateToMapWithRestaurant(restaurant)
                                }
                            }
                    }
                }
                .padding()
            }
            .background(Color.gray.opacity(0.2))
            .navigationTitle("모아보기")
        }
    }
} 