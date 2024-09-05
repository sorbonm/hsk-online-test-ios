//
//  MultipleChoiceCell.swift
//  HSK Online Test
//
//  Created by Sorboni Mumin on 05.09.2024.
//

import UIKit

class SixOptionsCell: UITableViewCell {
    
    let questionLabel = UILabel()
    var optionButtons: [UIButton] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(questionNumber: Int, options: [String]) {
        questionLabel.text = "\(questionNumber)"
        for (index, button) in optionButtons.enumerated() {
            button.setTitle(options[index], for: .normal)
        }
    }
    
    private func setupUI() {
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(questionLabel)
        
        // Настройка кнопок для вариантов ответа
        for _ in 0..<6 {
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = .yellow
            optionButtons.append(button)
            addSubview(button)
        }
        
        // Добавляем автолейаут
        NSLayoutConstraint.activate([
            questionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            questionLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        // Расположение кнопок
        var lastButton: UIButton?
        for button in optionButtons {
            NSLayoutConstraint.activate([
                button.leadingAnchor.constraint(equalTo: lastButton?.trailingAnchor ?? questionLabel.trailingAnchor, constant: 16),
                button.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
            ])
            lastButton = button
        }
    }
}

