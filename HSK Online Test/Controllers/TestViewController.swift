//
//  TestDetailViewController.swift
//  HSK Online Test
//
//  Created by Sorboni Mumin on 04.09.2024.
//

import PDFKit
import AVFoundation

class TestViewController: UIViewController, PDFViewDelegate {
    
    var level: HSKLevel
    var test: Test
    var pdfView: PDFView!
    var player: AVPlayer?
    var isPlaying = false
    var countdownTimer: Timer?
    var totalTime = 0
    var currentQuestion: String?
    
    var questionViewController: QuestionViewController!
    
    init(level: HSKLevel, test: Test) {
        self.level = level
        self.test = test
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Настройка PDFView
        pdfView = PDFView()
        pdfView.autoScales = true
        pdfView.delegate = self
        view.addSubview(pdfView)
        
        // Настройка кнопки воспроизведения
        let audioBtn = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(toggleAudio))
        navigationItem.rightBarButtonItem = audioBtn
        
        let baseDirectory = getLocalDirectoryPath(level: level, testName: test.name)
        
        // Загрузка PDF файла
        let questionPDF = baseDirectory.appendingPathComponent(test.questionPDF)
        if FileManager.default.fileExists(atPath: questionPDF.path) {
            if let document = PDFDocument(url: questionPDF) {
                pdfView.document = document
            } else {
                print("Ошибка загрузки PDF документа")
            }
        } else {
            print("PDF файл не найден: \(questionPDF)")
        }
        
        // Настройка аудиоплеера
        let audioPath = baseDirectory.appendingPathComponent(test.audio)
        if FileManager.default.fileExists(atPath: audioPath.path) {
            let playerItem = AVPlayerItem(url: audioPath)
            player = AVPlayer(playerItem: playerItem)
        } else {
            print("Аудио файл не найден: \(audioPath)")
        }
        
        // Запуск таймера
        totalTime = level.duration * 60
        startTimer()
        
        // Проверка изменения страницы
        NotificationCenter.default.addObserver(self, selector: #selector(handlePageChange), name: .PDFViewPageChanged, object: pdfView)
        
        addQuestionViewController()
         
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        toggleAudio()
    }
    
    private func getLocalDirectoryPath(level: HSKLevel, testName: String) -> URL {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        // Создаем путь для HSK/HSK{level}/{testName}
        let directoryURL = documentsURL
            .appendingPathComponent("HSK")
            .appendingPathComponent(level.directory)
            .appendingPathComponent(testName)
        
        return directoryURL
    }

     
     func addQuestionViewController() {
         questionViewController = QuestionViewController(questions: level.answerOption, level: level, test: test)
         addChild(questionViewController)
         view.addSubview(questionViewController.view)
         questionViewController.didMove(toParent: self)
     }
     
     func setupConstraints() {
         // Ограничения для pdfView (занимает 70% экрана)
         pdfView.snp.makeConstraints { make in
             make.top.equalToSuperview()
             make.leading.trailing.equalToSuperview()
             make.height.equalToSuperview().multipliedBy(0.75)
         }
         
         // Ограничения для questionViewController.view (занимает 25% экрана)
         questionViewController.view.snp.makeConstraints { make in
             make.top.equalTo(pdfView.snp.bottom)
             make.leading.trailing.bottom.equalToSuperview()
         }
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
    
    @objc func handlePageChange() {
        print("Страница изменена через уведомление")
        pdfViewPageChanged(pdfView)
    }
    
    func pdfViewPageChanged(_ sender: PDFView) {
        guard let currentPage = pdfView.currentPage else { return }
        let pageIndex = pdfView.document?.index(for: currentPage) ?? 0
        print("Пользователь перешёл на страницу: \(pageIndex + 1)")
        
        let pageText = currentPage.string ?? ""
        updateCurrentQuestion(from: pageText)
    }
    
    // Обновляем текущий вопрос на основе текста страницы
    func updateCurrentQuestion(from pageText: String) {
        // Создаём массив для всех вопросов, которые найдем на текущей странице
        var foundQuestions = [Int]()
        
        for i in 1...40 {
            let pattern = "\\b\(i)\\."
            let regex = try! NSRegularExpression(pattern: pattern)
            let range = NSRange(location: 0, length: pageText.utf16.count)
            
            // Если нашёлся хотя бы один вопрос, добавляем его в массив найденных
            if regex.firstMatch(in: pageText, options: [], range: range) != nil {
                foundQuestions.append(i)
            }
        }
        
        // Если найдено несколько вопросов, прокручиваем до первого найденного
        if let firstQuestion = foundQuestions.first {
            currentQuestion = "Вопрос \(firstQuestion)"
            print("Вопрос \(firstQuestion)")
            
            // Прокрутка до первого найденного вопроса
            questionViewController.scrollToQuestion(number: firstQuestion)
        } else {
            print("Вопросы не найдены на текущей странице")
        }
    }

    
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
    }
    
    func formatTime(_ seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
