//
//  HomePageTests.swift
//  CubMuTests
//
//  Created by Stefan Jivalino on 14/08/23.
//

import XCTest
@testable import CubMu
import CoreData

final class HomePageTests: XCTestCase {
    var viewModel: HomePageViewModel!
    var mockedService: HomePageMockService!
    private var appContext: NSManagedObjectContext?
    
    
    override func setUp() {
        mockedService = HomePageMockService()
        viewModel = .init(withHomePage: mockedService)
        
        appContext = createInMemoryManagedObjectContext()
    }

    func testGetCoupon() {
        viewModel.getCoupon(coupunType: 0)
        XCTAssertNotNil(viewModel.couponData)
    }
    
    func testGetCategory() {
        viewModel.getAllCategory()
        XCTAssertNotNil(viewModel.categoryData)
    }
    
    func testRedeemCoupon() {
        let couponItem = RedeemedCouponItem(context: self.appContext!)
        couponItem.couponId = "1"

        do {
            try appContext?.save()
            XCTAssertEqual(couponItem.couponId, "1")
            
        } catch {
            XCTFail()
        }
    }
    
    func testRedeemedCouponData() {
        let couponItem = RedeemedCouponItem(context: self.appContext!)
        couponItem.couponId = "1"

        do {
            try appContext?.save()
            
        } catch {
        }
        
        let fetchRequest: NSFetchRequest<RedeemedCouponItem> = RedeemedCouponItem.fetchRequest()
        let result = try? appContext?.fetch(fetchRequest)
        let firstData = result?.first
        
        XCTAssertEqual(firstData?.couponId, "1")
    }
    
    func createInMemoryManagedObjectContext() -> NSManagedObjectContext? {
            
            guard let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main]) else { return nil }
            
            let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
            do {
                try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
            } catch {
                print("Error creating test core data store: \(error)")
                return nil
            }
            
            let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
            
            return managedObjectContext
        }
    
    

}

class TestCoreDataStack: NSObject {
    lazy var persistentContainer: NSPersistentContainer = {
        let description = NSPersistentStoreDescription()
        description.url = URL(fileURLWithPath: "/dev/null")
        let container = NSPersistentContainer(name: "your_model_name")
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
}
