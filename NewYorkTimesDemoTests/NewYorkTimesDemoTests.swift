//
//  NewYorkTimesDemoTests.swift
//  NewYorkTimesDemoTests
//
//  Created by Zhaoyang Li on 10/30/20.
//

import XCTest
@testable import NewYorkTimesDemo

class NewsDataTests: XCTestCase {
    
    var newsCellViewModel: NewsCellViewModel?
    var topStoriesViewModel: TopStoriesViewModel?
    
    func testInitializer() {
        let dummyJson: [String: Any] = [
            "abstract": "Ms. McKibbin, who finished third on the inaugural season of the reality talent show in 2002, died on Sunday because of a brain aneurysm, her husband said.",
            "byline": "BY MARIE FAZIO",
            "created_date": "2020-11-01T16:35:26-05:00",
            "first_published_date": "2020-11-01T16:35:26-05:00",
            "item_type": "Article",
            "multimedia": [
            [
            "caption": "Nikki McKibbin finished third in the first season of \\U201cAmerican Idol,\\U201d behind Kelly Clarkson and Justin Guarini.",
            "copyright": "Kevin Winter/Getty Images/FOX",
            "format": "Standard Thumbnail",
            "height": 75,
            "subtype": "photo",
            "type": "image",
            "url": "https://static01.nyt.com/images/2020/11/01/multimedia/01xp-mckibbin3/01xp-mckibbin3-thumbStandard.jpg",
            "width": 75
                ]
            ],
            "published_date": "2020-11-01T16:35:26-05:00",
            "section": "Arts",
            "source": "New York Times",
            "subsection": "Television",
            "thumbnail_standard": "https://static01.nyt.com/images/2020/11/01/multimedia/01xp-mckibbin3/01xp-mckibbin3-thumbStandard.jpg",
            "title": "Nikki McKibbin, \\U2018American Idol\\U2019 Finalist, Dies at 42",
            "updated_date": "2020-11-01T16:35:26-05:00",
            "url": "https://www.nytimes.com/2020/11/01/arts/television/nikki-mckibbin-dead.html"
        ]
        
        do {
            let data = try JSONSerialization.data(withJSONObject: dummyJson, options: .fragmentsAllowed)
            let newsData = try JSONDecoder().decode(NewsData.self, from: data)
            XCTAssertEqual(newsData.abstract, dummyJson["abstract"] as? String)
            XCTAssertEqual(newsData.timeString, dummyJson["created_date"] as? String)
            
            let asyncExpect = expectation(description: "tests for service response")
            
            let service = ServiceManager.shared
            let parameters = [AppConstants.apiKeyQuery: AppConstants.apiKeyValue]
            service.fetchData(url: AppConstants.rootURLString, parameters: parameters, type: Response.self) { response, error in
                // error from server
                asyncExpect.fulfill()
                XCTAssertNil(error)
                XCTAssertEqual(response?.status, "OK")
                // whole json is nil
                XCTAssertNotNil(response?.results)
                
                // nil detail data
                XCTAssertNotNil(response?.results?.first?.multiMedia)
                XCTAssertNotNil(response?.results?.first?.multiMedia?.first?.caption)
                
                // tests for properties
                if let nonnilNewsData = response?.results?.first {
                    self.newsCellViewModel = NewsCellViewModel(nonnilNewsData)
                    XCTAssertNotNil(self.newsCellViewModel?.abstract)
                    XCTAssertNotNil(self.newsCellViewModel?.timeString)
                    XCTAssertNotNil(self.newsCellViewModel?.section)
                    XCTAssertNotNil(self.newsCellViewModel?.source)
                    XCTAssertNotNil(self.newsCellViewModel?.subSection)
                    XCTAssertNotNil(self.newsCellViewModel?.newsDetailsUrl)
                    XCTAssertNotNil(self.newsCellViewModel?.multiMedia)
                } else {
                    XCTFail()
                }
            }            
            wait(for: [asyncExpect], timeout: 60)
        }
        catch {
            XCTFail()
        }        
    }
}
