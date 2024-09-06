//
//  TestDownloadManager.swift
//  HSK Online Test
//
//  Created by Sorboni Mumin on 06.09.2024.
//

import Foundation

class TestDownloadManager {
    
    let defaults = UserDefaults.standard
    
    // Метод для сохранения информации о скаченном тесте
    func markTestAsDownloaded(testName: String) {
        var downloadedTests = defaults.array(forKey: "DOWNLOADED_TESTS") as? [String] ?? []
        if !downloadedTests.contains(testName) {
            downloadedTests.append(testName)
            defaults.set(downloadedTests, forKey: "DOWNLOADED_TESTS")
        }
    }
    
    // Проверяем, скачен ли тест
    func isTestDownloaded(testName: String) -> Bool {
        let downloadedTests = defaults.array(forKey: "DOWNLOADED_TESTS") as? [String] ?? []
        return downloadedTests.contains(testName)
    }
    
    // Метод для удаления теста из списка скаченных
    func removeTestFromDownloaded(testName: String) {
        var downloadedTests = defaults.array(forKey: "DOWNLOADED_TESTS") as? [String] ?? []
        if let index = downloadedTests.firstIndex(of: testName) {
            downloadedTests.remove(at: index)
            defaults.set(downloadedTests, forKey: "DOWNLOADED_TESTS")
        }
    }
    
    // Метод для получения всех скаченных тестов
    func getAllDownloadedTests() -> [String] {
        return defaults.array(forKey: "DOWNLOADED_TESTS") as? [String] ?? []
    }
}
