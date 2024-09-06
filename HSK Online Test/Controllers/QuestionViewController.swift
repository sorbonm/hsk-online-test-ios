//
//  QuestionViewController.swift
//  HSK Online Test
//
//  Created by Sorboni Mumin on 05.09.2024.
//

import UIKit

class QuestionViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TrueFalseCell.self, forCellReuseIdentifier: "TrueFalseCell")
        tableView.register(ThreeOptionsCell.self, forCellReuseIdentifier: "ThreeOptionsCell")
        tableView.register(FourOptionsCell.self, forCellReuseIdentifier: "FourOptionsCell")
        tableView.register(SixOptionsCell.self, forCellReuseIdentifier: "SixOptionsCell")
        tableView.register(TextInputCell.self, forCellReuseIdentifier: "TextInputCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        return tableView
    }()
    
    var level: HSKLevel
    var test: Test
    var questions: [Answer]
    
    var correctAnswers: [CorrectAnswer] = []
    
    init(questions: [Answer], level: HSKLevel, test: Test) {
        self.questions = questions
        self.level = level
        self.test = test
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupFooterView()
        
        let path = Bundle.main.path(forResource: level.answerJSONFilename, ofType: "json")
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path!))
            let correctAnswersJSON = loadCorrectAnswers(from: data)
            correctAnswers = correctAnswersJSON["\(test.name)"] ?? []
            print(correctAnswersJSON["\(test.name)"] ?? [])
        } catch {
            print("Ошибка при чтении файла: \(error.localizedDescription)")
        }
        
    }
    
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // Устанавливаем footerView с кнопкой "Результат"
    private func setupFooterView() {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        
        let resultButton = UIButton(type: .system)
        resultButton.setTitle("Результат", for: .normal)
        resultButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        resultButton.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
        
        footerView.addSubview(resultButton)
        
        // Устанавливаем ограничения для кнопки
        resultButton.snp.makeConstraints { make in
            make.center.equalTo(footerView)
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
        
        // Устанавливаем footer для таблицы
        tableView.tableFooterView = footerView
    }
    
    // MARK: - Действие при нажатии на кнопку "Результат"
    @objc private func resultButtonTapped() {
        print(questions)
        let resultVC = TestResultViewController(questions: questions, correctAnswers: correctAnswers)
        navigationController?.pushViewController(resultVC, animated: true)
    }
    
    
    // Метод для декодирования JSON и преобразования в массив CorrectAnswer
    func loadCorrectAnswers(from jsonData: Data) -> [String: [CorrectAnswer]] {
        do {
            let decoder = JSONDecoder()
            // Декодируем JSON в словарь, где ключ - это строка (например, "H10901"), а значение - массив ответов
            let decodedDictionary = try decoder.decode([String: [CorrectAnswerJSON]].self, from: jsonData)

            var correctAnswersDictionary: [String: [CorrectAnswer]] = [:]

            // Обработка каждого теста
            for (testKey, answers) in decodedDictionary {
                var correctAnswers: [CorrectAnswer] = []

                for answerJSON in answers {
                    let userAnswer: UserAnswer

                    switch answerJSON.correctAnswer {
                    case "trueFalse":
                        if case .bool(let value) = answerJSON.value {
                            userAnswer = .trueFalse(value)
                        } else {
                            continue
                        }

                    case "multipleChoice":
                        if case .string(let value) = answerJSON.value {
                            userAnswer = .multipleChoice(value)
                        } else {
                            continue
                        }

                    case "textInput":
                        if case .string(let value) = answerJSON.value {
                            userAnswer = .textInput(value)
                        } else {
                            continue
                        }

                    default:
                        continue
                    }

                    let correctAnswer = CorrectAnswer(number: answerJSON.number, correctAnswer: userAnswer)
                    correctAnswers.append(correctAnswer)
                }

                // Добавляем массив правильных ответов к ключу теста
                correctAnswersDictionary[testKey] = correctAnswers
            }

            return correctAnswersDictionary
        } catch {
            print("Ошибка при декодировании: \(error)")
            return [:]
        }
    }
    
}


// MARK: - UITableViewDelegate & UITableViewDataSource

extension QuestionViewController: UITableViewDataSource, UITableViewDelegate {
    func scrollToQuestion(number: Int) {
        let indexPath = IndexPath(row: number - 1, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let question = questions[indexPath.row]
        
        switch question.type {
        case .trueFalse:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrueFalseCell", for: indexPath) as! TrueFalseCell
            if case let .trueFalse(userAnswer) = question.userAnswer {
                cell.configure(questionNumber: question.number, userAnswer: userAnswer)
            } else {
                cell.configure(questionNumber: question.number, userAnswer: nil)
            }
            
            // Обработка выбранного ответа
            cell.onAnswerSelected = { [weak self] isTrue in
                self?.questions[indexPath.row].userAnswer = .trueFalse(isTrue)
            }
            return cell
            
        case .threeOptions(let options):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThreeOptionsCell", for: indexPath) as! ThreeOptionsCell
            if case let .multipleChoice(userAnswer) = question.userAnswer {
                cell.configure(questionNumber: question.number, options: options, selectedOption: userAnswer)
            } else {
                cell.configure(questionNumber: question.number, options: options, selectedOption: nil)
            }
            
            // Обработка выбранного ответа
            cell.onOptionSelected = { [weak self] selectedOption in
                self?.questions[indexPath.row].userAnswer = .multipleChoice(selectedOption)
            }
            return cell
            
        case .fourOptions(let options):
            let cell = tableView.dequeueReusableCell(withIdentifier: "FourOptionsCell", for: indexPath) as! FourOptionsCell
            if case let .multipleChoice(userAnswer) = question.userAnswer {
                cell.configure(questionNumber: question.number, options: options, selectedOption: userAnswer)
            } else {
                cell.configure(questionNumber: question.number, options: options, selectedOption: nil)
            }
            
            // Обработка выбранного ответа
            cell.onOptionSelected = { [weak self] selectedOption in
                self?.questions[indexPath.row].userAnswer = .multipleChoice(selectedOption)
            }
            return cell
            
        case .sixOptions(let options):
            let cell = tableView.dequeueReusableCell(withIdentifier: "SixOptionsCell", for: indexPath) as! SixOptionsCell
            if case let .multipleChoice(userAnswer) = question.userAnswer {
                cell.configure(questionNumber: question.number, options: options, selectedOption: userAnswer)
            } else {
                cell.configure(questionNumber: question.number, options: options, selectedOption: nil)
            }
            
            // Обработка выбранного ответа
            cell.onOptionSelected = { [weak self] selectedOption in
                self?.questions[indexPath.row].userAnswer = .multipleChoice(selectedOption)
            }
            return cell
            
        case .textInput:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextInputCell", for: indexPath) as! TextInputCell
            if case let .textInput(userAnswer) = question.userAnswer {
                cell.textField.text = userAnswer
            } else {
                cell.textField.text = ""
            }
            
            // Обработка текста
            cell.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            cell.textField.tag = indexPath.row // Используем тег для отслеживания ячейки
            return cell
        }
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        let index = textField.tag
        let text = textField.text ?? ""
        questions[index].userAnswer = .textInput(text)
    }
}

