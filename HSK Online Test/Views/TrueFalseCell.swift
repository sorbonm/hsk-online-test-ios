//
//  TrueFalseCell.swift
//  HSK Online Test
//
//  Created by Sorboni Mumin on 05.09.2024.
//

import UIKit

class TrueFalseCell: UITableViewCell {

    let questionLabel = UILabel()
    let trueButton = UIButton(type: .system)
    let falseButton = UIButton(type: .system)
    
    // Замыкание для передачи выбранного ответа
    var onAnswerSelected: ((Bool) -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
        // Отключаем выделение ячейки и интерактивность ячейки
        selectionStyle = .none
        self.isUserInteractionEnabled = false // Важно! Ячейка не должна обрабатывать события
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(questionNumber: Int, userAnswer: Bool?) {
        questionLabel.text = "\(questionNumber)"

        if let answer = userAnswer {
            updateButtons(isTrueSelected: answer)
        } else {
            updateButtons(isTrueSelected: nil) // Если ответа нет, сбросить состояние кнопок
        }
    }

    private func setupUI() {
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        trueButton.translatesAutoresizingMaskIntoConstraints = false
        falseButton.translatesAutoresizingMaskIntoConstraints = false

        trueButton.setTitle("True", for: .normal)
        trueButton.backgroundColor = .green
        trueButton.addTarget(self, action: #selector(trueButtonTapped), for: .touchUpInside)
        trueButton.isUserInteractionEnabled = true // Включаем интерактивность кнопки

        falseButton.setTitle("False", for: .normal)
        falseButton.backgroundColor = .red
        falseButton.addTarget(self, action: #selector(falseButtonTapped), for: .touchUpInside)
        falseButton.isUserInteractionEnabled = true // Включаем интерактивность кнопки

        contentView.addSubview(questionLabel)
        contentView.addSubview(trueButton)
        contentView.addSubview(falseButton)

        // Добавляем автолейаут
        NSLayoutConstraint.activate([
            questionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            questionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            trueButton.leadingAnchor.constraint(equalTo: questionLabel.trailingAnchor, constant: 16),
            trueButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            falseButton.leadingAnchor.constraint(equalTo: trueButton.trailingAnchor, constant: 16),
            falseButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    @objc private func trueButtonTapped() {
        onAnswerSelected?(true) // Возвращаем выбранный ответ как true
        updateButtons(isTrueSelected: true)
    }

    @objc private func falseButtonTapped() {
        onAnswerSelected?(false) // Возвращаем выбранный ответ как false
        updateButtons(isTrueSelected: false)
    }

    private func updateButtons(isTrueSelected: Bool?) {
        if let isTrueSelected = isTrueSelected {
            trueButton.backgroundColor = isTrueSelected ? .green : .lightGray
            falseButton.backgroundColor = isTrueSelected ? .lightGray : .red
        } else {
            // Сброс кнопок, если ответа нет
            trueButton.backgroundColor = .green
            falseButton.backgroundColor = .red
        }
    }
}



