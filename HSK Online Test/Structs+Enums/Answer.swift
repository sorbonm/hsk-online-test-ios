//
//  Question.swift
//  HSK Online Test
//
//  Created by Sorboni Mumin on 05.09.2024.
//

import Foundation

enum AnswerType {
    case trueFalse
    case threeOptions(options: [String])
    case fourOptions(options: [String])
    case sixOptions(options: [String])
    case textInput
}

enum UserAnswer: Equatable {
    case trueFalse(Bool?)
    case multipleChoice(String?)
    case textInput(String?)
    case none
    
    static func ==(lhs: UserAnswer, rhs: UserAnswer) -> Bool {
        switch (lhs, rhs) {
        case let (.trueFalse(lAnswer), .trueFalse(rAnswer)):
            return lAnswer == rAnswer
        case let (.multipleChoice(lAnswer), .multipleChoice(rAnswer)):
            return lAnswer == rAnswer
        case let (.textInput(lAnswer), .textInput(rAnswer)):
            return lAnswer == rAnswer
        case (.none, .none):
            return true
        default:
            return false
        }
    }
    
    var description: String {
        switch self {
        case .trueFalse(let answer):
            return answer == true ? "√" : "×"
        case .multipleChoice(let option):
            return option ?? "-"
        case .textInput(let text):
            return text ?? "-"
        case .none:
            return "-"
        }
    }
}

struct Answer {
    let number: Int
    let type: AnswerType
    var userAnswer: UserAnswer
}

struct CorrectAnswer {
    let number: Int
    let correctAnswer: UserAnswer
}


// Модель для представления данных JSON
struct CorrectAnswerJSON: Codable {
    let number: Int
    let correctAnswer: String
    let value: CodableValue
}

enum CodableValue: Codable {
    case bool(Bool)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let boolValue = try? container.decode(Bool.self) {
            self = .bool(boolValue)
        } else if let stringValue = try? container.decode(String.self) {
            self = .string(stringValue)
        } else {
            throw DecodingError.typeMismatch(CodableValue.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Не удалось декодировать значение"))
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let boolValue):
            try container.encode(boolValue)
        case .string(let stringValue):
            try container.encode(stringValue)
        }
    }
}
