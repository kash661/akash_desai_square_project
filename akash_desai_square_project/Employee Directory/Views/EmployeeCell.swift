//
//  EmployeeCell.swift
//  akash_desai_square_project
//
//  Created by Akash Desai on 2023-01-03.
//

import UIKit

class EmployeeCell: UITableViewCell {
    
    var presentation: Employee? {
        didSet {
            updateContents()
        }
    }
    
    lazy var employeeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let teamLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let summaryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(employeeImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(summaryLabel)
        contentView.addSubview(teamLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate(
            [
                employeeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                employeeImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
                employeeImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
                employeeImageView.widthAnchor.constraint(equalTo: employeeImageView.heightAnchor),
                
                teamLabel.leadingAnchor.constraint(equalTo: employeeImageView.trailingAnchor, constant: 12),
                teamLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
                
                nameLabel.leadingAnchor.constraint(equalTo: employeeImageView.trailingAnchor, constant: 12),
                nameLabel.topAnchor.constraint(equalTo: teamLabel.bottomAnchor, constant: 12),
                
                summaryLabel.leadingAnchor.constraint(equalTo: employeeImageView.trailingAnchor, constant: 12),
                summaryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
                summaryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -28)
            ]
        )
    }
    
    private func updateContents() {
        if let presentation = presentation {
            teamLabel.text = presentation.team
            nameLabel.text = presentation.fullName
            summaryLabel.text = presentation.biography
            employeeImageView.loadImage(fromURL: presentation.photoUrlSmall)
        } else {
            teamLabel.text = ""
            nameLabel.text = ""
            summaryLabel.text = ""
            employeeImageView.image = UIImage(systemName: "person.circle")
        }
    }
}
