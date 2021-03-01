//
//  ProfileView.swift
//  GitHubProfile
//
//  Created by Shanika Vithanage on 3/1/21.
//

import UIKit

class ProfileView: UIView {
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isScrollEnabled = true
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var lblProfile: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Profile"
        label.font = UIFont.appBoldFontWith(size: 20)
        return label
    }()
    
    lazy var userDetailsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 44
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var lblName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.appBoldFontWith(size: 32)
        return label
    }()
    
    lazy var lblUsername: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.appRegularFontWith(size: 16)
        return label
    }()
    
    lazy var lblEmail: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.appSemiBoldFontWith(size: 16)
        return label
    }()
    
    lazy var lblFollowersCount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "0"
        label.font = UIFont.appSemiBoldFontWith(size: 16)
        return label
    }()
    
    lazy var lblFollowers: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "followers"
        label.font = UIFont.appRegularFontWith(size: 16)
        return label
    }()
    
    lazy var lblFollowingCount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "0"
        label.font = UIFont.appSemiBoldFontWith(size: 16)
        return label
    }()
    
    lazy var lblFollowing: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "following"
        label.font = UIFont.appRegularFontWith(size: 16)
        return label
    }()
    
    lazy var lblPinned: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "Pinned"
        label.font = UIFont.appBoldFontWith(size: 24)
        return label
    }()
    
    lazy var btnPinnedViewAll: UIButton = {
        let button = UIButton()
        let attributedString = NSMutableAttributedString(string: "View all", attributes: viewAllBtnAttributes)
        button.setAttributedTitle(NSAttributedString(attributedString: attributedString), for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var pinnedCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(RepositoryCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var lblTop: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "Top repositories"
        label.font = UIFont.appBoldFontWith(size: 24)
        return label
    }()
    
    lazy var btnTopViewAll: UIButton = {
        let button = UIButton()
        let attributedString = NSMutableAttributedString(string: "View all", attributes: viewAllBtnAttributes)
        button.setAttributedTitle(NSAttributedString(attributedString: attributedString), for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var topCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(RepositoryCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var lblStarred: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "Starred repositories"
        label.font = UIFont.appBoldFontWith(size: 24)
        return label
    }()
    
    lazy var btnStarredViewAll: UIButton = {
        let button = UIButton()
        let attributedString = NSMutableAttributedString(string: "View all", attributes: viewAllBtnAttributes)
        button.setAttributedTitle(NSAttributedString(attributedString: attributedString), for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var starredCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(RepositoryCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let viewAllBtnAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.underlineStyle: 1,
                                                      NSAttributedString.Key.font: UIFont.appSemiBoldFontWith(size: 16),
                                                      NSAttributedString.Key.foregroundColor: UIColor.black]
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    private func setupViews() {
        setupScrollView()
        setupMainView()
        setupProfileLabel()
        
        setupUserDetailsView()
        setupProfileImageView()
        setupNameLabel()
        setupUsernameLabel()
        setupEmailLabel()
        setupFollowersCountLabel()
        setupFollowersLabel()
        setupFollowingCountLabel()
        setupFollowingLabel()
        
        setupPinnedLabel()
        setupPinnedViewAllButton()
        setupPinnedCollectionView()
        
        setupTopLabel()
        setupTopViewAllButton()
        setupTopCollectionView()
        
        setupStarredLabel()
        setupStarredViewAllButton()
        setupStarredCollectionView()
    }
    
    private func setupScrollView() {
        addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            scrollView.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor),
            scrollView.centerYAnchor.constraint(equalTo: layoutMarginsGuide.centerYAnchor)
        ])
    }
    
    private func setupMainView() {
        scrollView.addSubview(mainView)
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            mainView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            mainView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
        ])
    }
    
    private func setupProfileLabel() {
        mainView.addSubview(lblProfile)
        NSLayoutConstraint.activate([
            lblProfile.topAnchor.constraint(equalTo: mainView.topAnchor),
            lblProfile.centerXAnchor.constraint(equalTo: mainView.centerXAnchor)
        ])
    }
    
    private func setupUserDetailsView() {
        mainView.addSubview(userDetailsView)
        NSLayoutConstraint.activate([
            userDetailsView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            userDetailsView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            userDetailsView.topAnchor.constraint(equalTo: lblProfile.bottomAnchor, constant: 40)
        ])
    }
    
    private func setupProfileImageView() {
        userDetailsView.addSubview(profileImageView)
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 88),
            profileImageView.heightAnchor.constraint(equalToConstant: 88),
            profileImageView.topAnchor.constraint(equalTo: userDetailsView.topAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: userDetailsView.leadingAnchor),
        ])
    }
    
    private func setupNameLabel() {
        userDetailsView.addSubview(lblName)
        NSLayoutConstraint.activate([
            lblName.topAnchor.constraint(equalTo: userDetailsView.topAnchor, constant: 10),
            lblName.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 5),
        ])
    }
    
    private func setupUsernameLabel() {
        userDetailsView.addSubview(lblUsername)
        NSLayoutConstraint.activate([
            lblUsername.topAnchor.constraint(equalTo: lblName.bottomAnchor),
            lblUsername.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 5),
        ])
    }
    
    private func setupEmailLabel() {
        userDetailsView.addSubview(lblEmail)
        NSLayoutConstraint.activate([
            lblEmail.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 25),
            lblEmail.leadingAnchor.constraint(equalTo: userDetailsView.leadingAnchor),
        ])
    }
    
    private func setupFollowersCountLabel() {
        userDetailsView.addSubview(lblFollowersCount)
        NSLayoutConstraint.activate([
            lblFollowersCount.topAnchor.constraint(equalTo: lblEmail.bottomAnchor, constant: 20),
            lblFollowersCount.leadingAnchor.constraint(equalTo: userDetailsView.leadingAnchor),
        ])
    }
    
    private func setupFollowersLabel() {
        userDetailsView.addSubview(lblFollowers)
        NSLayoutConstraint.activate([
            lblFollowers.topAnchor.constraint(equalTo: lblEmail.bottomAnchor, constant: 20),
            lblFollowers.leadingAnchor.constraint(equalTo: lblFollowersCount.trailingAnchor, constant: 5),
        ])
    }
    
    private func setupFollowingCountLabel() {
        userDetailsView.addSubview(lblFollowingCount)
        NSLayoutConstraint.activate([
            lblFollowingCount.topAnchor.constraint(equalTo: lblEmail.bottomAnchor, constant: 20),
            lblFollowingCount.leadingAnchor.constraint(equalTo: lblFollowers.trailingAnchor, constant: 15),
        ])
    }
    
    private func setupFollowingLabel() {
        userDetailsView.addSubview(lblFollowing)
        NSLayoutConstraint.activate([
            lblFollowing.topAnchor.constraint(equalTo: lblEmail.bottomAnchor, constant: 20),
            lblFollowing.leadingAnchor.constraint(equalTo: lblFollowingCount.trailingAnchor, constant: 5),
            
            userDetailsView.bottomAnchor.constraint(equalTo: lblFollowing.bottomAnchor)
        ])
    }
    
    private func setupPinnedLabel() {
        mainView.addSubview(lblPinned)
        NSLayoutConstraint.activate([
            lblPinned.topAnchor.constraint(equalTo: userDetailsView.bottomAnchor, constant: 30),
            lblPinned.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
        ])
    }
    
    private func setupPinnedViewAllButton() {
        mainView.addSubview(btnPinnedViewAll)
        NSLayoutConstraint.activate([
            btnPinnedViewAll.topAnchor.constraint(equalTo: userDetailsView.bottomAnchor, constant: 30),
            btnPinnedViewAll.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
        ])
    }
    
    private func setupPinnedCollectionView() {
        mainView.addSubview(pinnedCollectionView)
        NSLayoutConstraint.activate([
            pinnedCollectionView.topAnchor.constraint(equalTo: lblPinned.bottomAnchor, constant: 10),
            pinnedCollectionView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            pinnedCollectionView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            pinnedCollectionView.heightAnchor.constraint(equalToConstant: 500),
        ])
    }
    
    private func setupTopLabel() {
        mainView.addSubview(lblTop)
        NSLayoutConstraint.activate([
            lblTop.topAnchor.constraint(equalTo: pinnedCollectionView.bottomAnchor, constant: 30),
            lblTop.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
        ])
    }
    
    private func setupTopViewAllButton() {
        mainView.addSubview(btnTopViewAll)
        NSLayoutConstraint.activate([
            btnTopViewAll.topAnchor.constraint(equalTo: pinnedCollectionView.bottomAnchor, constant: 30),
            btnTopViewAll.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
        ])
    }
    
    private func setupTopCollectionView() {
        mainView.addSubview(topCollectionView)
        NSLayoutConstraint.activate([
            topCollectionView.topAnchor.constraint(equalTo: lblTop.bottomAnchor, constant: 10),
            topCollectionView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            topCollectionView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            topCollectionView.heightAnchor.constraint(equalToConstant: 160),
        ])
    }
    
    private func setupStarredLabel() {
        mainView.addSubview(lblStarred)
        NSLayoutConstraint.activate([
            lblStarred.topAnchor.constraint(equalTo: topCollectionView.bottomAnchor, constant: 30),
            lblStarred.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
        ])
    }
    
    private func setupStarredViewAllButton() {
        mainView.addSubview(btnStarredViewAll)
        NSLayoutConstraint.activate([
            btnStarredViewAll.topAnchor.constraint(equalTo: topCollectionView.bottomAnchor, constant: 30),
            btnStarredViewAll.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
        ])
    }
    
    private func setupStarredCollectionView() {
        mainView.addSubview(starredCollectionView)
        NSLayoutConstraint.activate([
            starredCollectionView.topAnchor.constraint(equalTo: lblStarred.bottomAnchor, constant: 10),
            starredCollectionView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            starredCollectionView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            starredCollectionView.heightAnchor.constraint(equalToConstant: 160),
            
            mainView.bottomAnchor.constraint(equalTo: starredCollectionView.bottomAnchor)
        ])
    }
    
}
