//
//  LevelTestCell.swift
//  HSK Online Test
//
//  Created by Sorboni Mumin on 06.09.2024.
//

import UIKit

class LevelTestCell: UITableViewCell {
    
    // Заголовок
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    // Детали
    let detailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    // Кнопка загрузки
    let downloadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "icloud.and.arrow.down"), for: .normal)
        return button
    }()
    
    // Индикатор активности
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    // Замыкание для обработки нажатий
    var downloadAction: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Добавляем подэлементы на contentView
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailLabel)
        contentView.addSubview(downloadButton)
        contentView.addSubview(activityIndicator)
        
        accessoryType = .disclosureIndicator
        
        // Добавляем действие для кнопки
        downloadButton.addTarget(self, action: #selector(handleDownloadButtonTapped), for: .touchUpInside)
        
        // Устанавливаем ограничения через SnapKit
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Установка ограничений через SnapKit
    private func setupConstraints() {
        // Ограничения для titleLabel
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(10)
            make.trailing.equalTo(downloadButton.snp.leading).offset(-10)
        }
        
        // Ограничения для detailLabel
        detailLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.trailing.equalTo(titleLabel)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        // Ограничения для downloadButton
        downloadButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        // Ограничения для индикатора активности
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(downloadButton)
        }
    }
    
    // Действие при нажатии на кнопку загрузки
    @objc private func handleDownloadButtonTapped() {
        downloadAction?()
    }
    
    // Метод для отображения кнопки как загруженного файла
    func markAsDownloaded() {
        downloadButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        downloadButton.isHidden = false
        downloadButton.isEnabled = false
        activityIndicator.stopAnimating()
    }
    
    // Отображаем индикатор загрузки
    func setLoading(_ isLoading: Bool) {
        if isLoading {
            downloadButton.isHidden = true
            activityIndicator.startAnimating()
        } else {
            downloadButton.isHidden = false
            activityIndicator.stopAnimating()
        }
    }
}

