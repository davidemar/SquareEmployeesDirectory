// The image downloader was built using Jayesh Kawli's code from his article but with a repository instead of an array of cached images
//Also I am Saving in memory lower quality images instead of the full image.
// https://jayeshkawli.ghost.io/asynchronous-image-download-and-caching-in-swift/

import UIKit

protocol ProfilePictureRepositoryProtocol {
    func downloadImage(withImageUrlString imageUrlString: String?,
                       placeholderImage: UIImage?,
                       completionHandler: @escaping (UIImage?, Bool) -> Void)
}

final class ProfilePictureRepository: ProfilePictureRepositoryProtocol {

    private var imagesDownloadTasks: [String: URLSessionDataTask]
    private var profilePictureDiskCache: ProfilePictureDiskCache
    
    
    init(profilePictureDiskCache: ProfilePictureDiskCache) {
        imagesDownloadTasks = [:]
        self.profilePictureDiskCache = profilePictureDiskCache
    }

    func downloadImage(withImageUrlString imageUrlString: String?,
                       placeholderImage: UIImage?,
                       completionHandler: @escaping (UIImage?, Bool) -> Void) {

        guard let imageUrlString = imageUrlString else {
            completionHandler(placeholderImage, true)
            return
        }

        if let image = getImageFromRepository(url: imageUrlString) {
            completionHandler(image, true)
        } else {
            guard let url = URL(string: imageUrlString) else {
                completionHandler(placeholderImage, true)
                return
            }
            if let _ = getDataTaskFrom(urlString: imageUrlString) {
                return
            }
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                if let _ = error {
                    DispatchQueue.main.async {
                        completionHandler(placeholderImage, true)
                    }
                    return
                }

                guard let image = UIImage(data: data)?.resized(withPercentage: 0.4) else {
                    DispatchQueue.main.async {
                        completionHandler(placeholderImage, true)
                    }
                    Logger.shared.logError(errorString: "Can't get image from data")
                    return
                }
                self.saveImageInRepository(image: image, urlString: imageUrlString)
                self.imagesDownloadTasks.removeValue(forKey: imageUrlString)
                DispatchQueue.main.async {
                    completionHandler(image, false)
                }
            }
            imagesDownloadTasks[imageUrlString] = task
            task.resume()
        }
    }
    
    // MARK: Helper methods
    private func getDataTaskFrom(urlString: String) -> URLSessionTask? {
        return imagesDownloadTasks[urlString]
    }
    
    func saveImageInRepository(image: UIImage, urlString: String) {
        profilePictureDiskCache.storeImage(image: image, withUrlString: urlString)
    }
    
    func getImageFromRepository(url: String) -> UIImage? {
        return profilePictureDiskCache.getImage(by: url)
    }
    
}
