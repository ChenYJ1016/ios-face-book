//
//  PersonTableViewCell.swift
//  ios-face-book
//
//  Created by James Chen on 16/10/25.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    static let identifier = "PersonTableViewCell"
    

    // MARK: - UI Components
    private let personImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        // Make the image view circular.
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray5 // A placeholder color
        return imageView
    }()
    
    private let personNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .label
        return label
    }()
    
    private let personEmailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    // A stack view to hold the name and email labels vertically.
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [personNameLabel, personEmailLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    /// Configures the cell with data from a User object.
    /// - Parameter user: The user object containing the data to display.
    public func configure(with user: User) {
        personNameLabel.text = "\(user.firstName) \(user.lastName)"
        personEmailLabel.text = user.email
        // Use the downloaded image, or a default system image if it's not available.
        personImageView.image = user.profileImage ?? UIImage(systemName: "person.circle.fill")
    }
    
    /// Resets the cell's content before it's reused.
    override func prepareForReuse() {
        super.prepareForReuse()
        personImageView.image = nil
        personNameLabel.text = nil
        personEmailLabel.text = nil
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        // Add the views to the cell's content view.
        contentView.addSubview(personImageView)
        contentView.addSubview(labelsStackView)
        
        // Set up Auto Layout constraints.
        NSLayoutConstraint.activate([
            // Image View Constraints
            personImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            personImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            personImageView.widthAnchor.constraint(equalToConstant: 60),
            personImageView.heightAnchor.constraint(equalToConstant: 60),
            // Ensure the cell has a minimum height.
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 80),
            
            // Labels Stack View Constraints
            labelsStackView.centerYAnchor.constraint(equalTo: personImageView.centerYAnchor),
            labelsStackView.leadingAnchor.constraint(equalTo: personImageView.trailingAnchor, constant: 12),
            labelsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
}

