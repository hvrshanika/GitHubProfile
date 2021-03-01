//
//  RepositoryCell.swift
//  GitHubProfile
//
//  Created by Shanika Vithanage on 3/1/21.
//

import UIKit

let cellIdentifier = "RepositoryCell"

struct RepositoryCellItem {
    let ownerName: String
    let ownerImage: String
    let repoName: String
    let reposDesc: String
    let starCount: String
    let language: String
    let languageColor: String
}

class RepositoryCell: UICollectionViewCell {
    
    lazy var mainCellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var lblUsername: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.appRegularFontWith(size: 16)
        return label
    }()
    
    lazy var lblRepoName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.appSemiBoldFontWith(size: 16)
        return label
    }()
    
    lazy var lblRepoDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.appRegularFontWith(size: 16)
        return label
    }()
    
    lazy var starImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "star.fill")
        view.tintColor = .yellow
        return view
    }()
    
    lazy var lblStarCount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.appRegularFontWith(size: 16)
        return label
    }()
    
    lazy var roundImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "circle.fill")
        view.tintColor = .orange
        return view
    }()
    
    lazy var lblLanguage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.appRegularFontWith(size: 16)
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews() {
        setupMainCellView()
        setupProfileImageView()
        setupUsernameLabel()
        setupRepoNameLabel()
        setupRepoDescriptionLabel()
        setupStarImageView()
        setupStarCountLabel()
        setupRoundImageView()
        setupLanguageLabel()
    }
    
    private func setupMainCellView() {
        addSubview(mainCellView)
        NSLayoutConstraint.activate([
            mainCellView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            mainCellView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            mainCellView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            mainCellView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
        ])
    }
    
    private func setupProfileImageView() {
        mainCellView.addSubview(profileImageView)
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 32),
            profileImageView.heightAnchor.constraint(equalToConstant: 32),
            profileImageView.topAnchor.constraint(equalTo: mainCellView.topAnchor, constant: 10),
            profileImageView.leadingAnchor.constraint(equalTo: mainCellView.leadingAnchor, constant: 10),
        ])
    }
    
    private func setupUsernameLabel() {
        mainCellView.addSubview(lblUsername)
        NSLayoutConstraint.activate([
            lblUsername.topAnchor.constraint(equalTo: mainCellView.topAnchor, constant: 18),
            lblUsername.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 5),
        ])
    }
    
    private func setupRepoNameLabel() {
        mainCellView.addSubview(lblRepoName)
        NSLayoutConstraint.activate([
            lblRepoName.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 5),
            lblRepoName.leadingAnchor.constraint(equalTo: mainCellView.leadingAnchor, constant: 10),
        ])
    }
    
    private func setupRepoDescriptionLabel() {
        mainCellView.addSubview(lblRepoDescription)
        NSLayoutConstraint.activate([
            lblRepoDescription.topAnchor.constraint(equalTo: lblRepoName.bottomAnchor, constant: 5),
            lblRepoDescription.leadingAnchor.constraint(equalTo: mainCellView.leadingAnchor, constant: 10),
            lblRepoDescription.trailingAnchor.constraint(equalTo: mainCellView.trailingAnchor, constant: 10),
        ])
    }
    
    private func setupStarImageView() {
        mainCellView.addSubview(starImageView)
        NSLayoutConstraint.activate([
            starImageView.widthAnchor.constraint(equalToConstant: 12),
            starImageView.heightAnchor.constraint(equalToConstant: 12),
            starImageView.topAnchor.constraint(equalTo: lblRepoDescription.bottomAnchor, constant: 19),
            starImageView.leadingAnchor.constraint(equalTo: mainCellView.leadingAnchor, constant: 10),
        ])
    }
    
    private func setupStarCountLabel() {
        mainCellView.addSubview(lblStarCount)
        NSLayoutConstraint.activate([
            lblStarCount.topAnchor.constraint(equalTo: lblRepoDescription.bottomAnchor, constant: 15),
            lblStarCount.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 2),
        ])
    }
    
    private func setupRoundImageView() {
        mainCellView.addSubview(roundImageView)
        NSLayoutConstraint.activate([
            roundImageView.widthAnchor.constraint(equalToConstant: 12),
            roundImageView.heightAnchor.constraint(equalToConstant: 12),
            roundImageView.topAnchor.constraint(equalTo: lblRepoDescription.bottomAnchor, constant: 19),
            roundImageView.leadingAnchor.constraint(equalTo: lblStarCount.trailingAnchor, constant: 30),
        ])
    }
    
    private func setupLanguageLabel() {
        mainCellView.addSubview(lblLanguage)
        NSLayoutConstraint.activate([
            lblLanguage.topAnchor.constraint(equalTo: lblRepoDescription.bottomAnchor, constant: 15),
            lblLanguage.leadingAnchor.constraint(equalTo: roundImageView.trailingAnchor, constant: 2),
        ])
    }
    
}
