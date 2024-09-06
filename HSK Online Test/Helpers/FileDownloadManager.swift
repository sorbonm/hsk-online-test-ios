//
//  FileDownloadManager.swift
//  HSK Online Test
//
//  Created by Sorboni Mumin on 06.09.2024.
//

import Foundation
import FirebaseStorage

class FileDownloadManager {
    
    let storage = Storage.storage()
    
    // Метод для загрузки PDF и аудио файлов
    func downloadFiles(for test: Test, directory: String, completion: @escaping (Bool) -> Void) {
        let basePath = "HSK/\(directory)/\(test.name)/"
        
        // Получение ссылки на PDF файл вопросов
        let questionPDFRef = storage.reference(withPath: basePath + test.questionPDF)
        
        // Получение ссылки на AAC файл аудио
        let audioAACRef = storage.reference(withPath: basePath + test.audio)
        
        // Загрузка PDF файла
        downloadFile(reference: questionPDFRef, fileName: test.questionPDF, directory: directory, testName: test.name) { success in
            if !success {
                completion(false)
                return
            }
            
            // Загрузка аудио файла
            self.downloadFile(reference: audioAACRef, fileName: test.audio, directory: directory, testName: test.name) { success in
                completion(success)
            }
        }
    }
    
    // Метод для загрузки конкретного файла
    private func downloadFile(reference: StorageReference, fileName: String, directory: String, testName: String, completion: @escaping (Bool) -> Void) {
        let localURL = getLocalFileURL(fileName: fileName, directory: directory, testName: testName)
        
        // Загрузка файла в локальное хранилище
        reference.write(toFile: localURL) { url, error in
            if let error = error {
                print("Ошибка загрузки файла: \(error.localizedDescription)")
                completion(false)
            } else {
                print("Файл успешно загружен: \(fileName)")
                completion(true)
            }
        }
    }
    
    // Метод для получения локального пути файла с правильной иерархией директорий
    private func getLocalFileURL(fileName: String, directory: String, testName: String) -> URL {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        // Создаем путь для HSK/HSK{level}/{test.name}/
        let directoryURL = documentsURL
            .appendingPathComponent("HSK")
            .appendingPathComponent(directory)
            .appendingPathComponent(testName)
        
        // Создаем директорию, если она не существует
        if !fileManager.fileExists(atPath: directoryURL.path) {
            try? fileManager.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
        }
        
        return directoryURL.appendingPathComponent(fileName)
    }
    
    // Метод для удаления файлов и директории
    func deleteFiles(for test: Test, directory: String) {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        // Путь к директории теста HSK/HSK{level}/{test.name}
        let testDirectoryURL = documentsURL
            .appendingPathComponent("HSK")
            .appendingPathComponent(directory)
            .appendingPathComponent(test.name)
        
        // Проверяем, существует ли директория
        if fileManager.fileExists(atPath: testDirectoryURL.path) {
            do {
                // Удаляем всю директорию с файлами
                try fileManager.removeItem(at: testDirectoryURL)
                print("Директория теста \(test.name) успешно удалена.")
            } catch {
                print("Ошибка удаления директории теста \(test.name): \(error)")
            }
        } else {
            print("Директория теста \(test.name) не найдена.")
        }
    }
    
    // Метод для проверки, существует ли файл или директория (например, чтобы проверить, скачаны ли файлы)
    func isTestDownloaded(for test: Test, directory: String) -> Bool {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        // Путь к директории теста
        let testDirectoryURL = documentsURL
            .appendingPathComponent("HSK")
            .appendingPathComponent(directory)
            .appendingPathComponent(test.name)
        
        // Проверяем, существует ли директория
        return fileManager.fileExists(atPath: testDirectoryURL.path)
    }
}

