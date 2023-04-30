//
//  AlgoliaController.swift
//  SNS
//
//  Created by Rio Nagasaki on 2023/01/01.
//

import SwiftUI
import InstantSearch
import InstantSearchSwiftUI
import AlgoliaSearchClient
import InstantSearchCore
import InstantSearchTelemetry
import Foundation

class AlgoliaController {
    let searcher: HitsSearcher
    
    let searchBoxInteractor: SearchBoxInteractor
    let searchBoxController: SearchBoxObservableController
    
    let hitsInteractor: HitsInteractor<LessonRecords>
    let hitsController: HitsObservableController<LessonRecords>
    
    let statsInteractor: StatsInteractor
    let statsController: StatsTextObservableController
    
    let filterState: FilterState
    
    let facetListInteractor: FacetListInteractor
    let facetListController: FacetListObservableController
    
    let loadingInteractor: LoadingInteractor
    let loadingController: LoadingObservableController
    
    
    init() {
        searcher = HitsSearcher(appID: "0RBIQR42FK",
                                apiKey: "88520fcd1c7093407c06bbb794e93223",
                                indexName: "Lesson")
        self.searchBoxInteractor = .init()
        self.searchBoxController = .init()
        self.hitsInteractor = .init()
        self.hitsController = .init()
        self.statsInteractor = .init()
        self.statsController = .init()
        self.filterState = .init()
        self.facetListInteractor = .init()
        self.facetListController = .init()
        self.loadingInteractor = .init()
        self.loadingController = .init()
        setupConnections()
    }
    
    func setupConnections() {
        searchBoxInteractor.connectSearcher(searcher)
        searchBoxInteractor.connectController(searchBoxController)
        hitsInteractor.connectSearcher(searcher)
        hitsInteractor.connectController(hitsController)
        statsInteractor.connectSearcher(searcher)
        statsInteractor.connectController(statsController)
        searcher.connectFilterState(filterState)
        facetListInteractor.connectSearcher(searcher, with: "bigCategory")
        facetListInteractor.connectFilterState(filterState, with: "bigCategory", operator: .or)
        facetListInteractor.connectController(facetListController, with: FacetListPresenter(sortBy: [.isRefined, .count(order: .descending)]))
        loadingInteractor.connectSearcher(searcher)
        loadingInteractor.connectController(loadingController)
    }
}
