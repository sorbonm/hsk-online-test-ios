//
//  TestDetailViewController.swift
//  HSK Online Test
//
//  Created by Sorboni Mumin on 04.09.2024.
//

import PDFKit
import AVFoundation

class TestViewController: UIViewController, PDFViewDelegate {
    
    var level: HSKLevel!
    var test: Test!
    var pdfView: PDFView!
    var player: AVPlayer?
    var isPlaying = false
    var countdownTimer: Timer?
    var totalTime = 0
    var currentQuestion: String?
    
    var questionViewController: QuestionViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Настройка PDFView
        pdfView = PDFView(frame: .zero)
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        pdfView.autoScales = true
        pdfView.delegate = self
        view.addSubview(pdfView)
        
        // Настройка кнопки воспроизведения
        let audioBtn = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(toggleAudio))
        navigationItem.rightBarButtonItem = audioBtn
        
        let baseURL = "HSK/" + level.directory + "/" + test.name + "/"
        
        // Загрузка PDF файла
        let questionPDF = baseURL + test.questionPDF
        if let pdfURL = Bundle.main.url(forResource: questionPDF, withExtension: nil) {
            if let document = PDFDocument(url: pdfURL) {
                pdfView.document = document
            } else {
                print("Ошибка загрузки PDF документа")
            }
        } else {
            print("PDF файл не найден: \(questionPDF)")
        }
        
        // Настройка аудиоплеера
        let audio = baseURL + test.audio
        if let audioURL = Bundle.main.url(forResource: audio, withExtension: nil) {
            let playerItem = AVPlayerItem(url: audioURL)
            player = AVPlayer(playerItem: playerItem)
        } else {
            print("Аудио файл не найден: \(audio)")
        }
        
        // Запуск таймера
        totalTime = level.duration * 60
        startTimer()
        
        // Проверка изменения страницы
        NotificationCenter.default.addObserver(self, selector: #selector(handlePageChange), name: .PDFViewPageChanged, object: pdfView)
        
        addQuestionViewController()
         
        setupConstraints()
     }
     
     func addQuestionViewController() {
         questionViewController = QuestionViewController()
         addChild(questionViewController)
         questionViewController.view.translatesAutoresizingMaskIntoConstraints = false
         view.addSubview(questionViewController.view)
         questionViewController.didMove(toParent: self)
     }
     
     func setupConstraints() {
         // Ограничения для pdfView (занимает 70% экрана)
         NSLayoutConstraint.activate([
             pdfView.topAnchor.constraint(equalTo: view.topAnchor),
             pdfView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             pdfView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             pdfView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7)
         ])
         
         // Ограничения для questionViewController.view (занимает 30% экрана)
         NSLayoutConstraint.activate([
             questionViewController.view.topAnchor.constraint(equalTo: pdfView.bottomAnchor),
             questionViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             questionViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             questionViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
         ])
     }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            
            NotificationCenter.default.removeObserver(self, name: .PDFViewPageChanged, object: pdfView)
            countdownTimer?.invalidate()
            
            player?.pause()
            player?.replaceCurrentItem(with: nil)
            player = nil
            
            pdfView.document = nil
            pdfView.removeFromSuperview()
            pdfView = nil
        }
    }
    
    // Обработка изменения страницы
    @objc func handlePageChange() {
        print("Страница изменена через уведомление")
        pdfViewPageChanged(pdfView)
    }
    
    // MARK: - Отслеживание прогресса страницы
    func pdfViewPageChanged(_ sender: PDFView) {
        guard let currentPage = pdfView.currentPage else { return }
        
        // Получаем номер текущей страницы
        let pageIndex = pdfView.document?.index(for: currentPage) ?? 0
        print("Пользователь перешёл на страницу: \(pageIndex + 1)")
        
        // Здесь можно обновлять информацию о текущем вопросе, если он отображается
        let pageText = currentPage.string ?? ""
        updateCurrentQuestion(from: pageText)
    }
    
    // Обновляем текущий вопрос на основе текста страницы
    func updateCurrentQuestion(from pageText: String) {
        // Например, ищем наличие вопросов "1.", "2.", "3.", ...
        for i in 1...40 {
            if pageText.contains("\(i).") {
                currentQuestion = "Вопрос \(i)"
                print("Вопрос \(i)")
            }
        }
    }
    
    // MARK: - Аудио методы
    @objc func toggleAudio() {
        guard let player = player else { return }
        
        if isPlaying {
            player.pause()
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(toggleAudio))
        } else {
            player.play()
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .pause, target: self, action: #selector(toggleAudio))
        }
        
        isPlaying.toggle()
    }
    
    func playAudio() {
        player?.play()
        isPlaying = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .pause, target: self, action: #selector(toggleAudio))
    }
    
    // MARK: - Таймер
    
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if totalTime != 0 {
            totalTime -= 1
            navigationItem.title = formatTime(totalTime)
        } else {
            endTimer()
        }
    }
    
    func endTimer() {
        countdownTimer?.invalidate()
        countdownTimer = nil
        navigationItem.title = "Время вышло"
        
        // Здесь можно добавить логику для окончания теста или уведомления
    }
    
    func formatTime(_ seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
