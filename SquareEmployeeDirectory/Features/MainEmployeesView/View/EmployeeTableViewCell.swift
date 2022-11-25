//
//  EmployeeTableViewCell.swift
//  SquareEmployeeDirectory
//
//  Created by David Mar on 11/25/22.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {
    static let reuseIdentifier = "EmployeeTableViewCell"
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let phoneLabel: ContentLabel = {
        let label = ContentLabel()
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = ContentLabel()
        return label
    }()
    
    let teamLabel: UILabel = {
        let label = ContentLabel()
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = TitleLabel()
        return label
    }()
    
    let idLabel: UILabel = {
        let label = ContentLabel()
        return label
    }()
    
    let bioLabel: UILabel = {
        let label = ContentLabel()
        return label
    }()
    
    let cardView: UIView = {
        let cardView = UIView()
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 10.0
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        cardView.layer.shadowRadius = 6.0
        cardView.layer.shadowOpacity = 0.7
        return cardView
    }()
    
    //MARK: - ViewDidLoad
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCard()
        setupConstraints()
        contentView.backgroundColor = .systemGray4
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(viewModel: EmployeeViewModel) {
        viewModel.setupImage()
        setupViewModel(viewModel: viewModel)
        viewModel.reloadView = { [weak viewModel] in
            DispatchQueue.main.async {
                self.profileImage.image = viewModel?.photo
            }
        }
    }
    
    private func setupViewModel(viewModel: EmployeeViewModel) {
        self.phoneLabel.text = viewModel.phoneNumber
        self.emailLabel.text = viewModel.email
        self.teamLabel.text = viewModel.team
        self.nameLabel.text = viewModel.name
        self.bioLabel.text = viewModel.biography
        self.idLabel.text = viewModel.id
    }
    
}

// MARK: layouts
extension EmployeeTableViewCell {
    func setupCard() {
        contentView.addSubview(cardView)
        cardView.backgroundColor = .systemBackground
        cardView.addSubview(profileImage)
        cardView.addSubview(phoneLabel)
        cardView.addSubview(emailLabel)
        cardView.addSubview(teamLabel)
        cardView.addSubview(nameLabel)
        cardView.addSubview(idLabel)
        cardView.addSubview(bioLabel)
    }
    
    private func setCardViewConstraints() {
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        cardView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        cardView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.95).isActive = true
        cardView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.95).isActive = true
    }
    
    private func setNameLabelConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 32).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16).isActive = true
    }
    
    private func setTeamLabelConstraints() {
        teamLabel.translatesAutoresizingMaskIntoConstraints = false
        teamLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16).isActive = true
        teamLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16).isActive = true
    }
    
    private func setProfileImageConstraints() {
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 32).isActive = true
        profileImage.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -24).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func setPhoneLabelContraints() {
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.topAnchor.constraint(equalTo: teamLabel.bottomAnchor, constant: 8).isActive = true
        phoneLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16).isActive = true
    }
    
    private func setEmailLabelConstraints() {
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 8).isActive = true
        emailLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16).isActive = true
    }
    
    private func setIdLabelConstraints() {
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        idLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8).isActive = true
        idLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16).isActive = true
    }
    
    private func setBioLabelConstraints() {
        bioLabel.translatesAutoresizingMaskIntoConstraints = false
        bioLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 16).isActive = true
        bioLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16).isActive = true
        bioLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -24).isActive = true
        bioLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -24).isActive = true
    }
    
    private func setupConstraints() {
        setCardViewConstraints()
        setNameLabelConstraints()
        setTeamLabelConstraints()
        setProfileImageConstraints()
        setPhoneLabelContraints()
        setEmailLabelConstraints()
        setIdLabelConstraints()
        setBioLabelConstraints()
    }
}
