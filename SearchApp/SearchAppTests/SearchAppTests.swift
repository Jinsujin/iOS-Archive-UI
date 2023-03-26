//
//  SearchAppTests.swift
//  SearchAppTests
//
//  Created by Sujin Jin on 2023/03/26.
//

import XCTest
@testable import SearchApp

final class SearchAppTests: XCTestCase {

    func test_append_whenInitialized_shouldEmptyData() {
        let repository = RecentSearchRepository()
        XCTAssertEqual(0, repository.all().count)
    }
    
    func test_append_multipleData_matchCount() {
        let words = ["Apple", "Orange", "Cherry"]
        let repository = RecentSearchRepository(words: words)
        XCTAssertEqual(words.count, repository.all().count)
    }
    
    func test_prefix_matchCount() {
        let words = ["Apple", "Orange", "Cherry", "ABC"]
        let repository = RecentSearchRepository(words: words)
        let result = repository.prefixWords(with: "A")
        XCTAssertEqual(2, result.count)
    }
    
    func test_prefixOver_matchCount() {
        let words = ["Apple", "Orange", "Cherry", "ABC"]
        let repository = RecentSearchRepository(words: words)
        let result = repository.prefixWords(with: "Orangeee")
        XCTAssertEqual(0, result.count)
    }
    
    func testPerformance_after_repsotiry_search() throws {
        // dummy: ["ACvp", "W", "996V", "uk", "Dpv", "G", "pe",...]
        let dummy = generateRandomString(count: 1000)
        let repo = RecentSearchRepository(words: dummy)
        
        measure {
            for _ in 0..<10000 { // 0.036 sec: filter 를 사용했을때와 20배 차이
                let _ = repo.prefixWords(with: "A")
            }
        }
    }
    
    func testPerformance_search() throws {
        // dummy: ["ACvp", "W", "996V", "uk", "Dpv", "G", "pe",...]
        let dummy = generateRandomString(count: 1000)
        
        measure {
            for _ in 0..<10000 { // 0.751 sec
                let _ = dummy.filter({ $0.hasPrefix("A") })
            }
        }
    }
    
    private func generateRandomString(count: Int) -> [String] {
        var result = [String]()

        for _ in 1...count {
            let stringLength = Int.random(in: 1...5)
            let randomString = randomString(length: stringLength)
            result.append(randomString)
        }
        return result
    }
    
    private func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
