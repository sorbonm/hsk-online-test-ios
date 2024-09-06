//
//  MultipleChoiceCell.swift
//  HSK Online Test
//
//  Created by Sorboni Mumin on 05.09.2024.
//

import UIKit

class SixOptionsCell: UITableViewCell {
    
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .systemRed
        label.textAlignment = .center
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        return label
    }()
    
    var optionButtons: [UIButton] = []
    
    var onOptionSelected: ((String) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(questionNumber: Int, options: [String], selectedOption: String?) {
        questionLabel.text = "\(questionNumber)"
        
        for (index, button) in optionButtons.enumerated() {
            let option = options[index]
            button.setTitle(option, for: .normal)

            // Обновляем цвет кнопки в зависимости от выбранного состояния
            if let selectedOption = selectedOption, selectedOption == option {
                button.backgroundColor = .black
                button.setTitleColor(.white, for: .normal)
            } else {
                button.backgroundColor = .yellow
                button.setTitleColor(.black, for: .normal)
            }
        }
    }

    
    private func setupUI() {
        contentView.addSubview(questionLabel)
        
        // Настройка кнопок для вариантов ответа
        for _ in 0..<6 {
            let button = UIButton(type: .system)
            button.backgroundColor = .yellow
            button.setTitleColor(.black, for: .normal)
            button.layer.cornerRadius = 8
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.black.cgColor
            button.addTarget(self, action: #selector(optionButtonTapped(_:)), for: .touchUpInside)
            optionButtons.append(button)
            contentView.addSubview(button)
        }
        
        // Используем SnapKit для автолейаута
        questionLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.height.equalTo(40)
        }
        
        // Расположение кнопок с использованием SnapKit
        var lastButton: UIButton?
        for button in optionButtons {
            button.snp.makeConstraints { make in
                make.leading.equalTo(lastButton?.snp.trailing ?? questionLabel.snp.trailing).offset(8)
                make.centerY.equalTo(contentView.snp.centerY)
                make.width.equalTo(40)
                make.height.equalTo(40)
            }
            lastButton = button
        }
    }
    
    @objc private func optionButtonTapped(_ sender: UIButton) {
        guard let selectedTitle = sender.title(for: .normal) else { return }
        onOptionSelected?(selectedTitle)
        updateButtonSelection(selectedButton: sender)
    }
    
    private func updateButtonSelection(selectedButton: UIButton) {
        for button in optionButtons {
            if button == selectedButton {
                button.backgroundColor = .black
                button.setTitleColor(.white, for: .normal)
            } else {
                button.backgroundColor = .yellow
                button.setTitleColor(.black, for: .normal)
            }
        }
    }
}
