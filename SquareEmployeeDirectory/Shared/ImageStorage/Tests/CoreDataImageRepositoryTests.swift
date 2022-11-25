//
//  ImageRepositoryTests.swift
//  SquareEmployeeDirectoryTests
//
//  Created by David Mar on 11/24/22.
//

import XCTest
import CoreData
@testable import SquareEmployeeDirectory

class CoreDataImageRepositoryTests: XCTestCase {

    let container: NSPersistentContainer = {
        let bundle = Bundle(for: CoreDataImageRepositoryTests.self)
        let model = NSManagedObjectModel.mergedModel(from: [bundle])
        let container = NSPersistentContainer(name: "SquareEmployeeDirectory", managedObjectModel: model!)
        let description = NSPersistentStoreDescription()
        description.shouldAddStoreAsynchronously = false
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { _, _ in }
        return container
    }()
    
    var repository: CoreDataImageRepository!
    
    override func setUp() {
        super.setUp()
        do {
            let storage = try ImageStorage(name: "CoreDataImages-Article")
            repository = CoreDataImageRepository(container: container, imageStorage: storage)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func test_save_image() {
        let image = UIImage(named: "EmptyUserIcon")
        XCTAssertNotNil(image)
        repository.makeImageStoredInFileSystem(image!, urlString: "www.test.com/small.jpg")
    }
    
    func test_read_image() {
        let image = UIImage(named: "EmptyUserIcon")
        XCTAssertNotNil(image)
        repository.makeImageStoredInFileSystem(image!, urlString: "www.test.com/small.jpg")
        let savedImage = repository.findImage(by: "www.test.com/small.jpg")
        XCTAssertNotNil(savedImage)
    }
    
}
