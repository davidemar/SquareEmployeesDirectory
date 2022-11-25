//
//  ImageStorage.swift
//  SquareEmployeeDirectory
//
//  Created by David Mar on 11/24/22.
//

import Foundation
import UIKit

protocol ImageStorageProtocol {
    func setImage(_ image: UIImage, forKey key: String) throws
    func image(forKey key: String) throws -> UIImage
}

/// This class stores Image in File Manager
final class ImageStorage: ImageStorageProtocol {
    private let fileManager: FileManager
    private let path: String
    
    init(name: String, fileManager: FileManager = FileManager.default) throws {
        self.fileManager = fileManager
        let url = try fileManager.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let path = url.appendingPathComponent(name, isDirectory: true).path
        self.path = path
        try createDirectory()
        try setDirectoryAttributes([.protectionKey: FileProtectionType.complete])
    }
    
    func setImage(_ image: UIImage, forKey key: String) throws {
        guard let data = image.toData() else {
            throw Error.invalidImage
        }
        let filePath = makeFilePath(for: key)
        _ = fileManager.createFile(atPath: filePath, contents: data, attributes: nil)
    }
    
    func image(forKey key: String) throws -> UIImage {
        let filePath = makeFilePath(for: key)
        let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
        guard let image = UIImage(data: data) else {
            throw Error.invalidImage
        }
        return image
    }
}

// MARK: - File System Helpers
private extension ImageStorage {

    private func setDirectoryAttributes(_ attributes: [FileAttributeKey: Any]) throws {
        try fileManager.setAttributes(attributes, ofItemAtPath: path)
    }
    
    private func makeFileName(for key: String) -> String {
        let fileExtension = URL(fileURLWithPath: key).pathExtension
        return fileExtension.isEmpty ? key : "\(key).\(fileExtension)"
    }

    private func makeFilePath(for key: String) -> String {
        return "\(path)/\(makeFileName(for: key))"
    }
    
    private           func createDirectory() throws {
        guard !fileManager.fileExists(atPath: path) else {
            return
        }
        
        try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
    }
}

// MARK: - Error
private extension ImageStorage {
    enum Error: Swift.Error {
        case invalidImage
    }
}
