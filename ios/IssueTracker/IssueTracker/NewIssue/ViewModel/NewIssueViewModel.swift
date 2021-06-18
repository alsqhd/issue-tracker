//
//  NewIssueViewModel.swift
//  IssueTracker
//
//  Created by 지북 on 2021/06/15.
//

import Foundation

struct FilteringSection {
    var name: String
    var items: [Filterable]
    var collapsed: Bool
    
    init(name: String, items: [Filterable], collapsed: Bool = true) {
        self.name = name
        self.items = items
        self.collapsed = collapsed
      }
}


class NewIssueViewModel {
    private var postNewIssueUseCase: PostNewIssueUseCase
    var bodyText: String?
    var filteringSection: [FilteringSection] = []
    
    init(_ postNewIssueUseCase: PostNewIssueUseCase) {
        self.postNewIssueUseCase = postNewIssueUseCase
        load()
    }
    
    private func load() {
        let labelFilter = FilteringSection.init(name: "Label", items: [LabelMock.iOSLabel, LabelMock.BELabel, LabelMock.FELabel])
        let milestoneFilter = FilteringSection.init(name: "Milestone", items: [MilestoneMock.iOSFirstData, MilestoneMock.feFirstData])
        let assigneeFilter = FilteringSection.init(name: "Assignnee", items: [UserMock.dumba, UserMock.lia])
        
        filteringSection = [labelFilter,milestoneFilter,assigneeFilter]
    }
}
