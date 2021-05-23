//
//  SearchServiceTests.swift
//  TMDB-Demo Tests
//
//  Created by roohulk on 23/05/21.
//

import XCTest

@testable import TMDB_Demo
import XCTest

struct MockMovie: Searchable, Equatable {
    var searchableString: String {title}
    
    var title: String
    
    static var mockList: [MockMovie] {
        [MockMovie(title: "Dilwale Dulhania Le Jaayenge"), MockMovie(title: "The Godzila"), MockMovie(title: "The Garage"), MockMovie(title: "The Garbage Story"), MockMovie(title: "The Spider man"), MockMovie(title: "موسى")]
    }
}


class SearchServiceTests: XCTestCase {
    
    private var list: [MockMovie] = []
    
    override func setUp() {
        super.setUp()
        
        list = MockMovie.mockList
    }
    
    func testhasAwordBeginningWith() {
        //Given string = "The Godzila"
        let string = "The Godzila"
        
        //Then
        XCTAssertEqual(string.hasAwordBeginning(with: "the"), true)
        XCTAssertEqual(string.hasAwordBeginning(with: "gO"), true)
        XCTAssertEqual(string.hasAwordBeginning(with: "gd"), false)
        XCTAssertEqual(string.hasAwordBeginning(with: ""), true)
    }
    
    func testSearch() {
        
        //Given
        XCTAssert(list.contains(where: {$0.title == "Dilwale Dulhania Le Jaayenge"}), "Dilwale Dulhania Le Jaayenge is not in the list")
        XCTAssert(list.contains(where: {$0.title == "The Godzila"}), "The Godzila is not in the list")
        XCTAssert(list.contains(where: {$0.title == "The Garage"}), "The Garage is not in the list")
        XCTAssert(list.contains(where: {$0.title == "The Spider man"}), "The Garage is not in the list")
        XCTAssert(list.contains(where: {$0.title == "موسى"}), "موسى is not in the list")


        var filteredList: [MockMovie] = []
        
     //Case- 1
        
        //When
        
        filteredList = list.searchFilter(with: "Le Jaayenge Dilwale")

        //Then
        XCTAssertEqual(filteredList.contains(where: {$0.title == "Dilwale Dulhania Le Jaayenge"}), true, "Expected 'Dilwale Dulhania Le Jaayenge' for 'Le Jaayenge Dilwale' search term")
        XCTAssertEqual(filteredList.contains(where: {$0.title == "The Garage"}), false, "Not expected 'The Garage' for 'Le Jaayenge Dilwale' search term")

    //Case- 2

        //When
        filteredList = list.searchFilter(with: "the")

        //Then
        XCTAssertEqual(filteredList.contains(where: {$0.title == "The Garage"}), true, "Expected 'The Garage' for 'the' search term")
        XCTAssertEqual(filteredList.contains(where: {$0.title == "The Godzila"}), true, "Expected 'The Godzila' for 'the' search term")
        XCTAssertEqual(filteredList.contains(where: {$0.title == "The Godzila"}), true, "Expected 'Spider man' for 'the' search term")


        XCTAssertEqual(filteredList.contains(where: {$0.title == "Dilwale Dulhania Le Jaayenge"}), false, "Not expected DDLJ for 'the g' search term")

    //Case- 3

        //When
        filteredList = list.searchFilter(with: "the g")

        //Then
        XCTAssertEqual(filteredList.contains(where: {$0.title == "The Garage"}), true, "Expected 'The Garage' for 'the g' search term")
        XCTAssertEqual(filteredList.contains(where: {$0.title == "The Godzila"}), true, "Expected 'The Godzila' for 'the g' search term")

        XCTAssertEqual(filteredList.contains(where: {$0.title == "Dilwale Dulhania Le Jaayenge"}), false, "Not expected DDLJ for 'the g' search term")
        
    //Case- 4
           
           //When
           
           filteredList = list.searchFilter(with: "م")

           //Then
           XCTAssertEqual(filteredList.contains(where: {$0.title == "موسى"}), true, "Expected \("موسى") for \("م") search term")
           XCTAssertEqual(filteredList.contains(where: {$0.title == "The Godzila"}), false, "Not expected 'The Godzila' for \("م") search term")

    //Case- 5

        //When
        filteredList = list.searchFilter(with: "")

        //Then
        //The filtered list should have all the elements available in the original list.
        XCTAssertEqual(filteredList.count, list.count)


    //Case- 6
        
        XCTAssertEqual(list.searchFilter(with: "the"), list.searchFilter(with: " the"))
        XCTAssertEqual(list.searchFilter(with: "the"), list.searchFilter(with: "the "))
        XCTAssertEqual(list.searchFilter(with: "the"), list.searchFilter(with: " the "))


    //Case- 7
        
        //When
        filteredList = list.searchFilter(with: "any random text")

        //Then
        XCTAssertEqual(filteredList.count, 0)
    }
}
