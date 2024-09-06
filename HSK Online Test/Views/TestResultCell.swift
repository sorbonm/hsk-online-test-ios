//
//  ResultCell.swift
//  HSK Online Test
//
//  Created by Sorboni Mumin on 07.09.2024.
//

import UIKit

class TestResultCell: UITableViewCell {
    
    let questionNumberLabel = UILabel()
    let userAnswerLabel = UILabel()
    let correctAnswerLabel = UILabel()
    
    // Добавляем индикаторы (иконки) для правильных, неправильных и пропущенных ответов
    let resultIcon = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(questionNumberLabel)
        contentView.addSubview(userAnswerLabel)
        contentView.addSubview(correctAnswerLabel)
        contentView.addSubview(resultIcon)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        // Устанавливаем ограничения через SnapKit
        questionNumberLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.width.equalTo(50)
        }
        
        userAnswerLabel.snp.makeConstraints { make in
            make.leading.equalTo(questionNumberLabel.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
        }
        
        correctAnswerLabel.snp.makeConstraints { make in
            make.leading.equalTo(userAnswerLabel.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
        }
        
        resultIcon.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
    }

    func configure(questionNumber: Int, userAnswer: UserAnswer, correctAnswer: UserAnswer) {
        questionNumberLabel.text = "\(questionNumber)"
        userAnswerLabel.text = userAnswer.description // Для отображения ответа пользователя
        correctAnswerLabel.text = correctAnswer.description // Для отображения правильного ответа
        
        // Логика для установки правильной иконки в зависимости от ответа
        if userAnswer == correctAnswer {
            resultIcon.image = UIImage(systemName: "checkmark.circle.fill")
            resultIcon.tintColor = .green
        } else if userAnswer == .none {
            resultIcon.image = UIImage(systemName: "questionmark.circle.fill")
            resultIcon.tintColor = .blue
        } else {
            resultIcon.image = UIImage(systemName: "xmark.circle.fill")
            resultIcon.tintColor = .red
        }
    }
}
