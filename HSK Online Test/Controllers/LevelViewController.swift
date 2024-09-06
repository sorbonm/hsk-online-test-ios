//
//  LevelViewController.swift
//  HSK Online Test
//
//  Created by Sorboni Mumin on 06.09.2024.
//

import UIKit

class LevelViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LevelTestCell.self, forCellReuseIdentifier: "LevelTestCell")
        return tableView
    }()
    
    var test: HSKSection!
    
    var downloadedTests: [String] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        downloadedTests = TestDownloadManager().getAllDownloadedTests()
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        setupNavigationBar()
        setupTableView()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "HSK Level"
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
    func isTestDownloaded(test: Test) -> Bool {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let testDirectory = documentsURL.appendingPathComponent("HSK/\(test.name)")
        
        let pdfExists = fileManager.fileExists(atPath: testDirectory.appendingPathComponent(test.questionPDF).path)
        let audioExists = fileManager.fileExists(atPath: testDirectory.appendingPathComponent(test.audio.replacingOccurrences(of: ".mp3", with: ".aac")).path)
        
        return pdfExists && audioExists
    }
    
    func downloadTestMaterials(for level: HSKLevel, test: Test, completion: @escaping (Bool) -> Void) {
        let downloadManager = FileDownloadManager()
        downloadManager.downloadFiles(for: test, directory: level.directory) { success in
            completion(success)
        }
    }
    
    func showDownloadConfirmation(for testName: String, downloadAction: @escaping () -> Void) {
        let alert = UIAlertController(title: "Скачать тест?", message: "Вы хотите скачать тест \(testName)?", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Да", style: .default) { _ in
            downloadAction() // Выполняем действие загрузки, если пользователь согласен
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        // Показ алерта
        present(alert, animated: true, completion: nil)
    }

    
    func showDeleteConfirmation(for testName: String, deleteAction: @escaping () -> Void) {
        let alert = UIAlertController(title: "Удалить тест?", message: "Вы уверены, что хотите удалить тест \(testName)?", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Да", style: .destructive) { _ in
            deleteAction() // Выполняем действие удаления, если пользователь согласен
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        // Показ алерта
        present(alert, animated: true, completion: nil)
    }

}


// MARK: - UITableViewDataSource & UITableViewDelegate
extension LevelViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return test.tests.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return test.level.title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LevelTestCell", for: indexPath) as! LevelTestCell
        let currentTest = test.tests[indexPath.row]

        // Настраиваем текст для ячеек
        cell.titleLabel.text = currentTest.name
        cell.detailLabel.text = test.level.titleChinese

        // Настройка замыкания для обработки нажатий на кнопку загрузки
        cell.downloadAction = { [weak self] in
            guard let self = self else { return }

            // Проверка, загружены ли файлы
            if downloadedTests.contains(currentTest.name) {
                print("Файлы уже скачаны для теста: \(currentTest.name)")
            } else {
                self.showDownloadConfirmation(for: currentTest.name) {
                    print("showDownloadConfirmation")
                    // Показываем индикатор загрузки
                    cell.setLoading(true)
                    // Загружаем файлы
                    self.downloadTestMaterials(for: self.test.level, test: currentTest) { success in
                        DispatchQueue.main.async {
                            cell.setLoading(false)
                            if success {
                                cell.markAsDownloaded() // Помечаем, что файлы успешно скачаны
                                // Обновляем информацию о скачанном тесте в UserDefaults
                                self.downloadedTests.append(currentTest.name)
                                TestDownloadManager().markTestAsDownloaded(testName: currentTest.name)
                            } else {
                                // Возвращаем кнопку в исходное состояние при неудаче
                                cell.downloadButton.setImage(UIImage(systemName: "icloud.and.arrow.down"), for: .normal)
                            }
                        }
                    }
                }
            }
        }

        // Настройка иконки в зависимости от состояния загрузки
        if downloadedTests.contains(currentTest.name) {
            cell.markAsDownloaded()
        } else {
            cell.downloadButton.setImage(UIImage(systemName: "icloud.and.arrow.down"), for: .normal)
            cell.downloadButton.isEnabled = true
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentTest = test.tests[indexPath.row]
        if let index = self.downloadedTests.firstIndex(of: currentTest.name) {
            let level = test.level
            let test = test.tests[indexPath.row]
            let testVC = TestViewController(level: level, test: test)
            navigationController?.pushViewController(testVC, animated: true)
        } else {
            print("Test not downloaded!")
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Разрешаем редактирование строки
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let currentTest = test.tests[indexPath.row]
            // Показываем подтверждение для удаления
            showDeleteConfirmation(for: currentTest.name) {
                // Удаляем файлы из локального хранилища
                FileDownloadManager().deleteFiles(for: currentTest, directory: self.test.level.directory)
                TestDownloadManager().removeTestFromDownloaded(testName: currentTest.name)
                if let index = self.downloadedTests.firstIndex(of: currentTest.name) {
                    self.downloadedTests.remove(at: index)
                }
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }

    
    
}
