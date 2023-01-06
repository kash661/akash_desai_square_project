//
//  ImageCache.swift
//  akash_desai_squareProject
//
//  Created by Akash Desai on 2023-01-06.
//

import UIKit

class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSURLRequest, UIImage>()

    func setImage(_ image: UIImage, forKey key: URLRequest) {
        cache.setObject(image, forKey: key as NSURLRequest)
    }

    func image(forKey key: URLRequest) -> UIImage? {
        return cache.object(forKey: key as NSURLRequest)
    }
}
