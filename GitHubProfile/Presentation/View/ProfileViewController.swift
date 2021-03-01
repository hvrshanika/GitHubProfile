//
//  ViewController.swift
//  GitHubProfile
//
//  Created by Shanika Vithanage on 2/28/21.
//

import UIKit

protocol ProfileViewProtocol: class {
    func update(profileImage: String)
    func update(name: String)
    func update(username: String)
    func update(email: String)
    func update(followersCount: String)
    func update(followingCount: String)
    
    func update(pinnedItems: [RepositoryCellItem])
    func update(topItems: [RepositoryCellItem])
    func update(starredItems: [RepositoryCellItem])
    
    func errorOccured(error: String)
}

class ProfileViewController: UIViewController {
    
    var presenter: ProfilePresenter!
    
    var pinnedItems: [RepositoryCellItem]?
    var topItems: [RepositoryCellItem]?
    var starredItems: [RepositoryCellItem]?
    
    var refreshControl: UIRefreshControl?
    
    lazy var profileView: ProfileView = {
        let view = ProfileView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileView.pinnedCollectionView.dataSource = self
        profileView.pinnedCollectionView.delegate = self
        
        profileView.topCollectionView.dataSource = self
        profileView.topCollectionView.delegate = self
        
        profileView.starredCollectionView.dataSource = self
        profileView.starredCollectionView.delegate = self
        
        presenter = ProfilePresenter(view: self)
        presenter.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: #selector(refresh), for: .valueChanged)
        profileView.scrollView.refreshControl = refreshControl
    }
    
    override func loadView() {
        view = profileView
    }
    
    @objc func refresh() {
        presenter.onRefresh()
        refreshControl!.endRefreshing()
    }
    
    func showMessage(_ title: String?, message msg: String?) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel, handler: {(_ action: UIAlertAction?) -> Void in
            alert.dismiss(animated: true) {() -> Void in }
        })
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }

}

extension ProfileViewController: ProfileViewProtocol {
    
    func update(profileImage: String) {
        profileView.profileImageView.load(url: URL(string: profileImage)!)
    }
    
    func update(name: String) {
        profileView.lblName.text = name
    }
    
    func update(username: String) {
        profileView.lblUsername.text = username
    }
    
    func update(email: String) {
        profileView.lblEmail.text = email
    }
    
    func update(followersCount: String) {
        profileView.lblFollowersCount.text = followersCount
    }
    
    func update(followingCount: String) {
        profileView.lblFollowingCount.text = followingCount
    }
    
    func update(pinnedItems: [RepositoryCellItem]) {
        self.pinnedItems = pinnedItems
        profileView.pinnedCollectionView.reloadData()
    }
    
    func update(topItems: [RepositoryCellItem]) {
        self.topItems = topItems
        profileView.topCollectionView.reloadData()
    }
    
    func update(starredItems: [RepositoryCellItem]) {
        self.starredItems = starredItems
        profileView.starredCollectionView.reloadData()
    }
    
    func errorOccured(error: String) {
        showMessage("Error", message: error)
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == profileView.pinnedCollectionView {
            return pinnedItems?.count ?? 0
        } else if collectionView == profileView.topCollectionView {
            return topItems?.count ?? 0
        } else {
            return starredItems?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
                                                            for: indexPath) as? RepositoryCell else { return UICollectionViewCell() }
        
        var items: [RepositoryCellItem]?
        if collectionView == profileView.pinnedCollectionView  {
            items = self.pinnedItems
        } else if collectionView == profileView.topCollectionView {
            items = self.topItems
        } else {
            items = self.starredItems
        }
        
        if let item = items?[indexPath.row] {
            cell.lblUsername.text = item.ownerName
            cell.lblRepoName.text = item.repoName
            cell.lblRepoDescription.text = item.reposDesc
            cell.lblStarCount.text = item.starCount
            cell.lblLanguage.text = item.language
            cell.roundImageView.tintColor = UIColor(hexString: item.languageColor)
            
            cell.profileImageView.load(url: URL(string: item.ownerImage)!)
        }
        
        return cell
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = collectionView.frame.size.width
        
        if collectionView == profileView.pinnedCollectionView   {
            return CGSize(width: screenWidth, height: 160)
        }
        else {
            return CGSize(width: screenWidth*3/5, height: 160)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
}

