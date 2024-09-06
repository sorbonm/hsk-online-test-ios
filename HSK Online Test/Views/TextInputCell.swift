//
//  TextInputCell.swift
//  HSK Online Test
//
//  Created by Sorboni Mumin on 05.09.2024.
//

import UIKit

class TextInputCell: UITableViewCell {
    
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .systemRed
        label.textAlignment = .center
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        return label
    }()

    // MARK: - UI Components
    let textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter your answer"
        tf.borderStyle = .roundedRect
        return tf
    }()

    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(questionNumber: Int) {
        questionLabel.text = "\(questionNumber)"
    }

    // MARK: - Setup View
    private func setupView() {
        contentView.addSubview(questionLabel)
        contentView.addSubview(textField)
        
        // Настройка лейаута с использованием SnapKit
        questionLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        textField.snp.makeConstraints { make in
            make.leading.equalTo(questionLabel.snp.trailing).offset(16)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
            make.top.equalTo(contentView.snp.top).offset(8)
            make.bottom.equalTo(contentView.snp.bottom).offset(-8)
        }
    }
}
