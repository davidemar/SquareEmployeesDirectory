//
//  ImageWithFileSystemStorage+CoreDataClass.swift
//  SquareEmployeeDirectory
//
//  Created by David Mar on 11/24/22.
//

import UIKit
import CoreData

@objc(ImageWithFileSystemStorage)
public class ImageWithFileSystemStorage: NSManagedObject {
    lazy var image: UIImage? = {
        if let id = urlString {
            return try? storage?.image(forKey: id)
        }
        return nil
    }()
    
    var storage: ImageStorageProtocol?
    
    override public func awakeFromInsert() {
        super.awakeFromInsert()
        urlString = UUID().uuidString
    }
    
    override public func didSave() {
        super.didSave()
        if let image = image, let urlString = urlString {
            do {
                try storage?.setImage(image, forKey: urlString)
            } catch let error {
                Logger.shared.logError(error: error)
            }
        }
    }
}
