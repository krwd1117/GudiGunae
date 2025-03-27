//
//  CollectionView.swift
//  GuroGunae
//
//  Created by 김정완 on 2/26/25.
//

import SwiftUI
import Domain

import Kingfisher

struct CollectionView: View {
    @EnvironmentObject var coordinator: TabBarCoordinator
    @StateObject var viewModel: CollectionViewModel
    @ObservedObject var mapViewModel: MapViewModel
    
    // MARK: - UI States
    @State private var showDetailImage = false
    @State private var showShareSheet = false
    @State private var gridColumns = 2
    
    // MARK: - Constants
    private enum Layout {
        static let gridSpacing: CGFloat = 12
        static let cellCornerRadius: CGFloat = 12
        static let contentPadding: CGFloat = 16
    }
    
    private var columns: [GridItem] {
        Array(repeating: .init(.flexible(), spacing: Layout.gridSpacing), count: gridColumns)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: Layout.gridSpacing) {
                        ForEach(viewModel.filteredRestaurants) { restaurant in
                            CollectionCellView(
                                mapViewModel: mapViewModel,
                                collectionViewModel: viewModel,
                                viewModel: CollectionCellViewModel(restaurant: restaurant)
                            )
                            .environmentObject(coordinator)
                            .onTapGesture {
                                viewModel.selectedRestaurant = restaurant
                                showDetailImage = true
                            }
                            .background(Color(.systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: Layout.cellCornerRadius))
                            .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
                        }
                    }
                    .padding(Layout.contentPadding)
                }
                .refreshable {
                    await viewModel.fetchRestaurants()
                }
            }
            .navigationTitle("모아보기")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 16) {
                        // Grid Layout Toggle
                        Button {
                            withAnimation {
                                gridColumns = gridColumns == 2 ? 1 : 2
                            }
                        } label: {
                            Image(systemName: gridColumns == 2 ? "square.grid.2x2" : "rectangle.grid.1x2")
                                .symbolRenderingMode(.hierarchical)
                        }
                        .accessibilityLabel(gridColumns == 2 ? "그리드 보기" : "리스트 보기")
                        
                        // Share Button
                        Button {
                            Task {
                                await viewModel.createInitialShareItems()
                                showShareSheet = true
                            }
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                                .symbolRenderingMode(.hierarchical)
                        }
                        .disabled(viewModel.selectedRestaurants.isEmpty)
                        .accessibilityLabel("선택한 식당 공유하기")
                    }
                }
            }
        }
        .task {
            await viewModel.fetchRestaurants()
        }
        .fullScreenCover(isPresented: $showDetailImage) {
            if let imageURL = viewModel.selectedRestaurant?.imageURL {
                DetailImageView(
                    viewModel: DetailImageViewModel(imageURL: imageURL)
                )
            }
        }
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(activityItems: viewModel.activityItems)
                .presentationDetents([.medium, .large])
        }
    }
}
