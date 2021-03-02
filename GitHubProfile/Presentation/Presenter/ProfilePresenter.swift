//
//  ProfilePresenter.swift
//  GitHubProfile
//
//  Created by Shanika Vithanage on 2/28/21.
//

import Foundation

protocol ItemsViewPresenter: class {
    init(view: ProfileViewProtocol)
    func viewDidLoad()
    func onRefresh()
}

class ProfilePresenter: ItemsViewPresenter {
    
    weak var view: ProfileViewProtocol?
    
    required init(view: ProfileViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        fetchProfileInfo()
    }
    
    func onRefresh() {
        Apollo.shared.client.clearCache()
        fetchProfileInfo()
    }
    
    private func fetchProfileInfo() {
        let query = UserProfileQuery(username: "marcelofabri")
        Apollo.shared.client.fetch(query: query) { result in
          switch result {
          case .success(let graphQLResult):
            if let userProfile = graphQLResult.data?.user {
                self.processBasicProfile(userProfile: userProfile)
                
                self.processPinnedItems(userProfile: userProfile)
                self.processTopItems(userProfile: userProfile)
                self.processStarredItems(userProfile: userProfile)
            }
                
          case .failure(let error):
            self.view?.errorOccured(error: error.localizedDescription)
          }
        }
    }
    
    private func processBasicProfile(userProfile: UserProfileQuery.Data.User) {
        self.view?.update(username: userProfile.login)
        self.view?.update(profileImage: userProfile.avatarUrl)
        self.view?.update(email: userProfile.email)
        self.view?.update(followersCount: "\(userProfile.followers.totalCount)")
        self.view?.update(followingCount: "\(userProfile.following.totalCount)")
        if let name = userProfile.name {
            self.view?.update(name: name)
        }
    }
    
    private func processPinnedItems(userProfile: UserProfileQuery.Data.User) {
        var pinnedItems = [RepositoryCellItem]()
        userProfile.pinnedItems.nodes?.forEach { node in
            let repo = node?.fragments.repositoryFragment
            pinnedItems.append(processRepository(repo: repo))
        }
        let viewHeight = (pinnedItems.count * 160) + 10
        self.view?.update(pinnedItems: pinnedItems, hasItems: pinnedItems.count > 0, viewHeight: viewHeight)
    }
    
    private func processTopItems(userProfile: UserProfileQuery.Data.User) {
        var topItems = [RepositoryCellItem]()
        userProfile.topRepositories.nodes?.forEach { node in
            let repo = node?.fragments.repositoryFragment
            topItems.append(processRepository(repo: repo))
        }
        self.view?.update(topItems: topItems, hasItems: topItems.count > 0)
    }
    
    private func processStarredItems(userProfile: UserProfileQuery.Data.User) {
        var starredItems = [RepositoryCellItem]()
        userProfile.starredRepositories.nodes?.forEach { node in
            let repo = node?.fragments.repositoryFragment
            starredItems.append(processRepository(repo: repo))
        }
        self.view?.update(starredItems: starredItems, hasItems: starredItems.count > 0)
    }
    
    private func processRepository(repo: RepositoryFragment?) -> RepositoryCellItem {
        var ownerName = "", imgURL = ""
        if let user = repo?.owner.asUser {
            ownerName = user.login
            imgURL = user.avatarUrl
        } else if let org = repo?.owner.asOrganization {
            ownerName = org.name ?? "N/A"
            imgURL = org.avatarUrl
        }
        
        return RepositoryCellItem(ownerName: ownerName, ownerImage: imgURL, repoName: repo?.name ?? "N/A",
                                  reposDesc: repo?.description ?? "N/A",
                                  starCount: "\(repo?.stargazerCount ?? 0)",
                                  language: repo?.primaryLanguage?.name ?? "N/A",
                                  languageColor: repo?.primaryLanguage?.color ?? "#FFFF")
    }
}
