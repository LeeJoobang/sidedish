import XCTest
@testable import SideDish

class RepositoryTest: XCTestCase {
    
    private var dataCache: DataCacheable!
    private var networkHandler: NetworkHandlable!
    private var jsonHandler: JSONHandlable!
    private var repository: RepositoryApplicable!
    private var food: Food!

    
    override func setUp(){
        dataCache = MockDataCache()
        networkHandler = MockNetworkHandler()
        
        repository = Repository(networkHandler: networkHandler, jsonHandler: JSONHandler(), dataCache: dataCache)
        food = Food(detailHash: "hash2", alt: "alt", foodDescription: "description", normalPrice: "normalPrice", specialPrice: "specialPrice", deliveryInformation: ["deliveryInformation"], title: "title", imageUrl: "imageUrl", badges: ["badge"])
        super.setUp()
    }
    
    //네트워크 요청 테스트 -> 성공을 가정한 후, 데이터 캐시 처리까지 잘 되었는 지 캐싱된 데이터 개수를 확인하는 방식으로 테스트
    func testRequestingData() throws {
        
        repository.requestData(method: .get, contentType: .image, url: .mainImage(rawUrl: food.imageUrl)){ result in
            switch result{
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(_):
                XCTFail()
            }
        }
        
        XCTAssertGreaterThan(dataCache.count, 0)
    }
}
