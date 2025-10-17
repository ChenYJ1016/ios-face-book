//
//  UserDetailTableViewController.swift
//  ios-face-book
//
//  Created by James Chen on 17/10/25.
//

import UIKit

class UserDetailViewController: UITableViewController {

    var user: User
    
    // MARK: - UI Components
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 75
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray5
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        return label
    }()
    
    private let ageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        return label
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        return label
    }()
    
    private let birthDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        return label
    }()
    
    private let detailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    

    
    // MARK: - Lifecycle
    init(user: User) {
        self.user = user
        super.init(style: .insetGrouped)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .always
        
        setupUI()
        configureView()
    }
    
    private func configureView() {
        
        title = user.firstName
        profileImageView.image = user.profileImage ?? UIImage(systemName: "person.circle.fill")
        nameLabel.text = "\(user.firstName) \(user.lastName)"
        emailLabel.text = user.email
        ageLabel.text = "\(user.age) years old"
        birthDateLabel.text = "Birth Date: \(user.birthDate)"
        phoneLabel.text = user.phone
        
        
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        detailsStackView.addArrangedSubview(profileImageView)
        detailsStackView.addArrangedSubview(nameLabel)
        detailsStackView.addArrangedSubview(ageLabel)
        detailsStackView.addArrangedSubview(emailLabel)
        detailsStackView.addArrangedSubview(phoneLabel)
        
        view.addSubview(detailsStackView)
        
        NSLayoutConstraint.activate([
            // Image View
            profileImageView.widthAnchor.constraint(equalToConstant: 150),
            profileImageView.heightAnchor.constraint(equalToConstant: 150),
            
            // Stack View
            detailsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            detailsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            detailsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
