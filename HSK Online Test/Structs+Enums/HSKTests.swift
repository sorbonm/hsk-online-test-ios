//
//  HSKTests.swift
//  HSK Online Test
//
//  Created by Sorboni Mumin on 05.09.2024.
//
// Test — структура, представляющая тест с его именем.
// HSKTests — статическая структура, содержащая списки тестов для каждого уровня.
// Метод getTests(for:) позволяет получить список тестов для конкретного уровня.
//

import Foundation

struct Test {
    let name: String
    let questionPDF: String
    let answerPDF: String
    let audio: String
}

struct HSKSection {
    let level: HSKLevel
    let tests: [Test]
}

struct HSKTests {
    static let HSK1Tests = [
        Test(name: "H10000", questionPDF: "H10000_Q.pdf", answerPDF: "H10000_A.pdf", audio: "H10000_AUDIO.mp3"),
        Test(name: "H10901", questionPDF: "H10901_Q.pdf", answerPDF: "H10901_A.pdf", audio: "H10901_AUDIO.mp3"),
        Test(name: "H10902", questionPDF: "H10902_Q.pdf", answerPDF: "H10902_A.pdf", audio: "H10902_AUDIO.mp3"),
        Test(name: "H11003", questionPDF: "H11003_Q.pdf", answerPDF: "H11003_A.pdf", audio: "H11003_AUDIO.mp3"),
        Test(name: "H11004", questionPDF: "H11004_Q.pdf", answerPDF: "H11004_A.pdf", audio: "H11004_AUDIO.mp3"),
        Test(name: "H11005", questionPDF: "H11005_Q.pdf", answerPDF: "H11005_A.pdf", audio: "H11005_AUDIO.mp3"),
        Test(name: "H11329", questionPDF: "H11329_Q.pdf", answerPDF: "H11329_A.pdf", audio: "H11329_AUDIO.mp3"),
        Test(name: "H11330", questionPDF: "H11330_Q.pdf", answerPDF: "H11330_A.pdf", audio: "H11330_AUDIO.mp3"),
        Test(name: "H11331", questionPDF: "H11331_Q.pdf", answerPDF: "H11331_A.pdf", audio: "H11331_AUDIO.mp3"),
        Test(name: "H11332", questionPDF: "H11332_Q.pdf", answerPDF: "H11332_A.pdf", audio: "H11332_AUDIO.mp3"),
        Test(name: "H11334", questionPDF: "H11334_Q.pdf", answerPDF: "H11334_A.pdf", audio: "H11334_AUDIO.mp3")
    ]
    
    static let HSK2Tests = [
        Test(name: "H20000", questionPDF: "H20000_Q.pdf", answerPDF: "H20000_A.pdf", audio: "H20000_AUDIO.mp3"),
        Test(name: "H20901", questionPDF: "H20901_Q.pdf", answerPDF: "H20901_A.pdf", audio: "H20901_AUDIO.mp3"),
        Test(name: "H20902", questionPDF: "H20902_Q.pdf", answerPDF: "H20902_A.pdf", audio: "H20902_AUDIO.mp3"),
        Test(name: "H21003", questionPDF: "H21003_Q.pdf", answerPDF: "H21003_A.pdf", audio: "H21003_AUDIO.mp3"),
        Test(name: "H21004", questionPDF: "H21004_Q.pdf", answerPDF: "H21004_A.pdf", audio: "H21004_AUDIO.mp3"),
        Test(name: "H21005", questionPDF: "H21005_Q.pdf", answerPDF: "H21005_A.pdf", audio: "H21005_AUDIO.mp3"),
        Test(name: "H21329", questionPDF: "H21329_Q.pdf", answerPDF: "H21329_A.pdf", audio: "H21329_AUDIO.mp3"),
        Test(name: "H21330", questionPDF: "H21330_Q.pdf", answerPDF: "H21330_A.pdf", audio: "H21330_AUDIO.mp3"),
        Test(name: "H21331", questionPDF: "H21331_Q.pdf", answerPDF: "H21331_A.pdf", audio: "H21331_AUDIO.mp3"),
        Test(name: "H21332", questionPDF: "H21332_Q.pdf", answerPDF: "H21332_A.pdf", audio: "H21332_AUDIO.mp3"),
        Test(name: "H21334", questionPDF: "H21334_Q.pdf", answerPDF: "H21334_A.pdf", audio: "H21334_AUDIO.mp3")
    ]
    
    static let HSK3Tests = [
        Test(name: "H30000", questionPDF: "H30000_Q.pdf", answerPDF: "H30000_A.pdf", audio: "H30000_AUDIO.mp3"),
        Test(name: "H31001", questionPDF: "H31001_Q.pdf", answerPDF: "H31001_A.pdf", audio: "H31001_AUDIO.mp3"),
        Test(name: "H31002", questionPDF: "H31002_Q.pdf", answerPDF: "H31002_A.pdf", audio: "H31002_AUDIO.mp3"),
        Test(name: "H31003", questionPDF: "H31003_Q.pdf", answerPDF: "H31003_A.pdf", audio: "H31003_AUDIO.mp3"),
        Test(name: "H31004", questionPDF: "H31004_Q.pdf", answerPDF: "H31004_A.pdf", audio: "H31004_AUDIO.mp3"),
        Test(name: "H31005", questionPDF: "H31005_Q.pdf", answerPDF: "H31005_A.pdf", audio: "H31005_AUDIO.mp3"),
        Test(name: "H31327", questionPDF: "H31327_Q.pdf", answerPDF: "H31327_A.pdf", audio: "H31327_AUDIO.mp3"),
        Test(name: "H31328", questionPDF: "H31328_Q.pdf", answerPDF: "H31328_A.pdf", audio: "H31328_AUDIO.mp3"),
        Test(name: "H31329", questionPDF: "H31329_Q.pdf", answerPDF: "H31329_A.pdf", audio: "H31329_AUDIO.mp3"),
        Test(name: "H31330", questionPDF: "H31330_Q.pdf", answerPDF: "H31330_A.pdf", audio: "H31330_AUDIO.mp3"),
        Test(name: "H31332", questionPDF: "H31332_Q.pdf", answerPDF: "H31332_A.pdf", audio: "H31332_AUDIO.mp3")
    ]
    
    static let HSK4Tests = [
        Test(name: "H40000", questionPDF: "H40000_Q.pdf", answerPDF: "H40000_A.pdf", audio: "H40000_AUDIO.mp3"),
        Test(name: "HSK41002", questionPDF: "HSK41002_Q.pdf", answerPDF: "HSK41002_A.pdf", audio: "HSK41002_AUDIO.mp3"),
        Test(name: "HSK41003", questionPDF: "HSK41003_Q.pdf", answerPDF: "HSK41003_A.pdf", audio: "HSK41003_AUDIO.mp3"),
        Test(name: "HSK41004", questionPDF: "HSK41004_Q.pdf", answerPDF: "HSK41004_A.pdf", audio: "HSK41004_AUDIO.mp3"),
        Test(name: "HSK41005", questionPDF: "HSK41005_Q.pdf", answerPDF: "HSK41005_A.pdf", audio: "HSK41005_AUDIO.mp3"),
        Test(name: "HSK41006", questionPDF: "HSK41006_Q.pdf", answerPDF: "HSK41006_A.pdf", audio: "HSK41006_AUDIO.mp3"),
        Test(name: "HSK41007", questionPDF: "HSK41007_Q.pdf", answerPDF: "HSK41007_A.pdf", audio: "HSK41007_AUDIO.mp3"),
        Test(name: "HSK41008", questionPDF: "HSK41008_Q.pdf", answerPDF: "HSK41008_A.pdf", audio: "HSK41008_AUDIO.mp3"),
        Test(name: "HSK41009", questionPDF: "HSK41009_Q.pdf", answerPDF: "HSK41009_A.pdf", audio: "HSK41009_AUDIO.mp3"),
        Test(name: "HSK41328", questionPDF: "HSK41328_Q.pdf", answerPDF: "HSK41328_A.pdf", audio: "HSK41328_AUDIO.mp3"),
        Test(name: "HSK41329", questionPDF: "HSK41329_Q.pdf", answerPDF: "HSK41329_A.pdf", audio: "HSK41329_AUDIO.mp3"),
        Test(name: "HSK41332", questionPDF: "HSK41332_Q.pdf", answerPDF: "HSK41332_A.pdf", audio: "HSK41332_AUDIO.mp3")
    ]
    
    static let HSK5Tests = [
        Test(name: "H50000", questionPDF: "H50000_Q.pdf", answerPDF: "H50000_A.pdf", audio: "H50000_AUDIO.mp3"),
        Test(name: "H51001", questionPDF: "H51001_Q.pdf", answerPDF: "H51001_A.pdf", audio: "H51001_AUDIO.mp3"),
        Test(name: "H51002", questionPDF: "H51002_Q.pdf", answerPDF: "H51002_A.pdf", audio: "H51002_AUDIO.mp3"),
        Test(name: "H51003", questionPDF: "H51003_Q.pdf", answerPDF: "H51003_A.pdf", audio: "H51003_AUDIO.mp3"),
        Test(name: "H51004", questionPDF: "H51004_Q.pdf", answerPDF: "H51004_A.pdf", audio: "H51004_AUDIO.mp3"),
        Test(name: "H51005", questionPDF: "H51005_Q.pdf", answerPDF: "H51005_A.pdf", audio: "H51005_AUDIO.mp3"),
        Test(name: "H51327", questionPDF: "H51327_Q.pdf", answerPDF: "H51327_A.pdf", audio: "H51327_AUDIO.mp3"),
        Test(name: "H51328", questionPDF: "H51328_Q.pdf", answerPDF: "H51328_A.pdf", audio: "H51328_AUDIO.mp3"),
        Test(name: "H51329", questionPDF: "H51329_Q.pdf", answerPDF: "H51329_A.pdf", audio: "H51329_AUDIO.mp3"),
        Test(name: "H51330", questionPDF: "H51330_Q.pdf", answerPDF: "H51330_A.pdf", audio: "H51330_AUDIO.mp3"),
        Test(name: "H51332", questionPDF: "H51332_Q.pdf", answerPDF: "H51332_A.pdf", audio: "H51332_AUDIO.mp3")
    ]
    
    static let HSK6Tests = [
        Test(name: "H60000", questionPDF: "H60000_Q.pdf", answerPDF: "H60000_A.pdf", audio: "H60000_AUDIO.mp3"),
        Test(name: "H61001", questionPDF: "H61001_Q.pdf", answerPDF: "H61001_A.pdf", audio: "H61001_AUDIO.mp3"),
        Test(name: "H61002", questionPDF: "H61002_Q.pdf", answerPDF: "H61002_A.pdf", audio: "H61002_AUDIO.mp3"),
        Test(name: "H61003", questionPDF: "H61003_Q.pdf", answerPDF: "H61003_A.pdf", audio: "H61003_AUDIO.mp3"),
        Test(name: "H61004", questionPDF: "H61004_Q.pdf", answerPDF: "H61004_A.pdf", audio: "H61004_AUDIO.mp3"),
        Test(name: "H61005", questionPDF: "H61005_Q.pdf", answerPDF: "H61005_A.pdf", audio: "H61005_AUDIO.mp3"),
        Test(name: "H61327", questionPDF: "H61327_Q.pdf", answerPDF: "H61327_A.pdf", audio: "H61327_AUDIO.mp3"),
        Test(name: "H61328", questionPDF: "H61328_Q.pdf", answerPDF: "H61328_A.pdf", audio: "H61328_AUDIO.mp3"),
        Test(name: "H61329", questionPDF: "H61329_Q.pdf", answerPDF: "H61329_A.pdf", audio: "H61329_AUDIO.mp3"),
        Test(name: "H61330", questionPDF: "H61330_Q.pdf", answerPDF: "H61330_A.pdf", audio: "H61330_AUDIO.mp3"),
        Test(name: "H61332", questionPDF: "H61332_Q.pdf", answerPDF: "H61332_A.pdf", audio: "H61332_AUDIO.mp3")
    ]
    
    static func getTests(for level: HSKLevel) -> [Test] {
        switch level {
        case .level1:
            return HSK1Tests
        case .level2:
            return HSK2Tests
        case .level3:
            return HSK3Tests
        case .level4:
            return HSK4Tests
        case .level5:
            return HSK5Tests
        case .level6:
            return HSK6Tests
        }
    }
}
