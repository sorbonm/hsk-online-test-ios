//
//  TrueFalseCell.swift
//  HSK Online Test
//
//  Created by Sorboni Mumin on 05.09.2024.
//

import UIKit

class TrueFalseCell: UITableViewCell {
    // Замыкание для передачи выбранного ответа
    var onAnswerSelected: ((Bool) -> Void)?
    
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .systemRed
        label.textAlignment = .center
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        return label
    }()
    
    private lazy var trueButton: UIButton = {
        let button = UIButton()
        button.setTitle("√", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .yellow
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(trueButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var falseButton: UIButton = {
        let button = UIButton()
        button.setTitle("×", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .yellow
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(falseButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    var onButtonTap: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(questionNumber: Int, userAnswer: Bool?) {
        questionLabel.text = "\(questionNumber)"

        if let answer = userAnswer {
            updateButtons(isTrueSelected: answer)
        } else {
            updateButtons(isTrueSelected: nil)
        }
    }
    
    // MARK: - SetupUI
    func setupUI() {
        contentView.addSubview(questionLabel)
        contentView.addSubview(trueButton)
        contentView.addSubview(falseButton)
        setNeedsUpdateConstraints()
    }
    
    // MARK: - Life cycle
    override func updateConstraints() {
        questionLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.height.equalTo(40)
        }
        
        trueButton.snp.makeConstraints { make in
            make.leading.equalTo(questionLabel.snp.trailing).offset(8)
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.height.equalTo(40)
        }
        
        falseButton.snp.makeConstraints { make in
            make.leading.equalTo(trueButton.snp.trailing).offset(8)
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.height.equalTo(40)
        }
        super.updateConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    @objc private func trueButtonTapped() {
        onAnswerSelected?(true)
        updateButtons(isTrueSelected: true)
    }

    @objc private func falseButtonTapped() {
        onAnswerSelected?(false)
        updateButtons(isTrueSelected: false)
    }

    private func updateButtons(isTrueSelected: Bool?) {
        if let isTrueSelected = isTrueSelected {
            trueButton.backgroundColor = isTrueSelected ? .black : .yellow
            trueButton.setTitleColor(isTrueSelected ? .white : .black, for: .normal)
            
            falseButton.backgroundColor = isTrueSelected ? .yellow : .black
            falseButton.setTitleColor(isTrueSelected ? .black : .white, for: .normal)
        } else {
            // Сброс кнопок, если ответа нет
            trueButton.backgroundColor = .yellow
            falseButton.backgroundColor = .yellow
            trueButton.setTitleColor(.black, for: .normal)
            falseButton.setTitleColor(.black, for: .normal)
        }
    }
}




