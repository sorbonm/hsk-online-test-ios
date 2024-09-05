//
//  TextInputCell.swift
//  HSK Online Test
//
//  Created by Sorboni Mumin on 05.09.2024.
//

import UIKit

class TextInputCell: UITableViewCell {
    
    let questionLabel = UILabel()

    // MARK: - UI Components
    let textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter your answer"
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(questionNumber: Int) {
        questionLabel.text = "\(questionNumber)"
    }

    // MARK: - Setup View
    private func setupView() {
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(questionLabel)
        contentView.addSubview(textField)
        
        // Activate constraints
        NSLayoutConstraint.activate([
            // Question label constraints
            questionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            questionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            // TextField constraints
            textField.leadingAnchor.constraint(equalTo: questionLabel.trailingAnchor, constant: 16),
            //textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
