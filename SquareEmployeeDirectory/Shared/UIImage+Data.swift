//
//  UIImage+Data.swift
//  SquareEmployeeDirectory
//
//  Created by David Mar on 11/24/22.
//

import Foundation
import UIKit

extension UIImage {
    func toData() -> Data? {
        return pngData()
    }
    func resized(withPercentage percentage: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }   
}
