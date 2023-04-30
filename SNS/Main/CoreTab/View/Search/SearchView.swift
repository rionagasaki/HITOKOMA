//
//  SearchView.swift
//  SNS
//
//  Created by Rio Nagasaki on 2022/09/04.
//

import SwiftUI
import InstantSearchSwiftUI
import SDWebImageSwiftUI
import PartialSheet

struct SearchView:View {
    
    @State private var isPresentingFacets = false
    @StateObject private var viewModel = SearchViewModel()
    @ObservedObject var hitsController: HitsObservableController<LessonRecords>
    @ObservedObject var searchBoxController: SearchBoxObservableController
    @ObservedObject var statsController: StatsTextObservableController
    @ObservedObject var facetListController: FacetListObservableController
    @ObservedObject var loadingController: LoadingObservableController
    
    var body: some View{
        VStack(spacing: 7) {
            SearchBar(
                text: $searchBoxController.query,
                isEditing: $viewModel.isEditing,
                placeholder: "レッスン名、カテゴリー名、値段...",
                onSubmit: searchBoxController.submit
            )
            .padding(.horizontal, 16)
            
            Text(statsController.stats)
                .fontWeight(.light)
                .font(.system(size: 12))
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
                .padding(.leading, 16)
            
            if loadingController.isLoading {
                ProgressView()
            } else {
                HitsList(hitsController) {  (hit, _) in
                    NavigationLink {
                        if let hit = hit {
                            OneClassDetailView(
                                viewModel: OneClassDetailViewModel(
                                    lessonId: hit.objectID))
                        } else {
                            EmptyView()
                        }
                    } label: {
                        SearchResultCellView(
                            lessonImageURLString: (hit?.lessonImageURLString).orEmpty,
                            lessonName: (hit?.lessonName).orEmpty,
                            bigCategory: (hit?.bigCategory).orEmpty,
                            mentorImageURLString: viewModel.mentorImageURLString,
                            lessonContents: (hit?.lessonContent).orEmpty,
                            budget: (hit?.budget).orEmptyNum
                        )
                        .onAppear{
                            FetchFromFirestore()
                                .fetchOtherUserInfoFromFirestore(uid: hit!.mentorUid) { user in
                                    viewModel.mentorImageURLString = user.profileImage
                                    viewModel.mentorName = user.username
                                }
                        }
                    }
                } noResults: {
                    VStack {
                        Spacer()
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 70)
                            .foregroundColor(.init(uiColor: .lightGray))
                        
                        Text("レッスンが見つかりませんでした。\nキーワードを変えて、再度お試しください。")
                            .fontWeight(.heavy)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 15))
                        Spacer()
                    }
                }
            }
            Spacer()
        }
        .navigationTitle("検索")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: facetsButton())
        .partialSheet(
            isPresented: $isPresentingFacets,
            type: .scrollView(height: UIScreen.main.bounds.height/2, showsIndicators: false),
            content: facets
        )
    }
    
    @ViewBuilder
    private func facets() -> some View {
        NavigationView {
            VStack {
                HStack(alignment: .top) {
                    Image(systemName: "checkmark.circle")
                        .resizable()
                        .frame(width: 30, height:30)
                        .foregroundColor(.green)
                    Text("検索範囲をカテゴライズすることができます。\nチェックマークをつけてから検索を行ってください。")
                        .fontWeight(.light)
                        .font(.system(size: 12))
                }
                FacetList(facetListController) { facet, isSelected in
                    VStack {
                        HStack {
                            if facet.value == "IT" {
                                Image(image.category.technology.basicInformation.name)
                                    .resizable()
                                    .frame(width: 30, height:30)
                                    .scaledToFit()
                                    .padding(.leading, 16)
                            } else if facet.value == "法律" {
                                Image(image.category.law.law.name)
                                    .resizable()
                                    .frame(width: 30, height:30)
                                    .scaledToFit()
                                    .padding(.leading, 16)
                            }
                            FacetRow(facet: facet, isSelected: isSelected)
                                .padding(.leading, 8)
                                .padding(.trailing, 16)
                        }
                        Divider()
                    }
                } noResults: {
                    Text("No facet found")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                Spacer()
            }
            .navigationBarTitle("カテゴライズ")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    private func facetsButton() -> some View {
        Button(action: {
            isPresentingFacets.toggle()
        },
               label: {
            Image(systemName: "line.horizontal.3.decrease.circle")
        })
    }
}

struct SearchView_Preview: PreviewProvider {
    
    static let algoliaController = AlgoliaController()
    
    static var previews: some View {
        NavigationView {
            SearchView(
                hitsController: algoliaController.hitsController,
                searchBoxController: algoliaController.searchBoxController,
                statsController: algoliaController.statsController, facetListController: algoliaController.facetListController,
                loadingController: algoliaController.loadingController
            )
        }.onAppear {
            algoliaController.searcher.search()
        }
    }
}

struct SearchCategoriesCellView:View {
    
    let searchCategory:SearchCategory
    var body: some View{
        HStack{
            Image(systemName:searchCategory.categoryImageName).foregroundColor(Color.white)
            Text(searchCategory.categoryName).foregroundColor(Color.white)
        }
    }
}

struct SearchCategory:Identifiable{
    var id = UUID()
    var categoryName:String
    var categoryImageName: String
    var rightArrowsImageName:String = ""
}

struct SearchResultCellView: View {
    let lessonImageURLString: String
    let lessonName: String
    let bigCategory: String
    let mentorImageURLString: String
    let lessonContents: String
    let budget: Int
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top){
                WebImage(url: URL(string: lessonImageURLString))
                    .resizable()
                    .frame(width: 70, height: 70)
                    .cornerRadius(10)
                    .padding(.leading, 8)
                VStack(alignment: .leading, spacing: .zero){
                    Text(lessonName)
                        .fontWeight(.medium)
                        .font(.system(size: 15))
    
                    HStack(spacing: .zero){
                        Text(bigCategory)
                            .font(.system(size: 10))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .foregroundColor(.white)
                            .background(Color.customBlue)
                            .cornerRadius(10)
                            
                        Text(lessonContents)
                            .fontWeight(.light)
                            .font(.system(size: 10))
                            .lineLimit(1)
                            .padding(.leading, 5)
                        Spacer()
                    }
                    .padding(.top, 5)
                    
                    HStack {
                        WebImage(url: URL(string: mentorImageURLString))
                            .resizable()
                            .frame(width:20, height:20)
                            .clipShape(Circle())
                        Text("\(budget)円")
                            .fontWeight(.light)
                            .font(.system(size: 12))
                            .padding(.leading, 16)
                    }
                    .padding(.top, 8)
                }
            }
            Divider()
        }
    }
}
