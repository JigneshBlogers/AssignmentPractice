
import XCTest
@testable import AssignmentJignesh

class AboutCanadaTests: XCTestCase {

    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_AboutCanadaData_Success() {
        let exceptations = self.expectation(description: "Get canada data")
        let viewmodel = AboutCanadaViewModel()
        viewmodel.fetchFeedsResults(url: Constants.APIEndPoint.baseURL) { (result) in
            switch result {
            case .success(let success):
                XCTAssertTrue(success)
                exceptations.fulfill()
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }

    func test_APIService_InValidURL() {
        let exceptations = self.expectation(description: "InValidURL")
        let viewmodel = AboutCanadaViewModel()
        viewmodel.fetchFeedsResults(url: "") { (result) in
            switch result {
            case .success(let success):
                XCTAssertFalse(success)
            case .failure(let error):
                XCTAssertEqual(error.errorDescription!, Constants.ErrorMessages.invalidURL)
                exceptations.fulfill()
            }
        }
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }

    func test_APIService_InvalidData() {
        let exceptations = self.expectation(description: "InvalidData")
        let viewmodel = AboutCanadaViewModel()
        viewmodel.fetchFeedsResults(url: "https://www.") { (result) in
            switch result {
            case .success(let success):
                XCTAssertFalse(success)
            case .failure(let error):
                XCTAssertEqual(error.errorDescription!, Constants.ErrorMessages.invalidData)
                exceptations.fulfill()
            }
        }
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }

    func test_APIService_DecodingFailed() {
        let exceptations = self.expectation(description: "DecodingFailed")
        let viewmodel = AboutCanadaViewModel()
        viewmodel.fetchFeedsResults(url: "https://www.google.com") { (result) in
            switch result {
            case .success(let success):
                XCTAssertFalse(success)
            case .failure(let error):
                XCTAssertEqual(error.errorDescription!, Constants.ErrorMessages.decodingFailed)
                exceptations.fulfill()
            }
        }
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }

}
