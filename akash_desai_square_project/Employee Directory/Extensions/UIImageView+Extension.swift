//
//  UIImageView+Extension.swift
//  akash_desai_squareProject
//
//  Created by Akash Desai on 2023-01-06.
//

import UIKit

public extension UIImageView {
    
    func loadImage(fromURL url: String) {
        guard let imageURL = URL(string: url) else { return }
        
        let cache = ImageCache.shared
        let request = URLRequest(url: imageURL)
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let image = cache.image(forKey: request) {
                DispatchQueue.main.async {
                    self.transition(toImage: image)
                }
            } else {
                URLSession.shared.dataTask(with: request) { (data, response, error) in
                    if let data = data, let response = response {
                        if ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300 {
                            if let image = UIImage(data: data) {
                                cache.setImage(image, forKey: request)
                                DispatchQueue.main.async {
                                    self.transition(toImage: image)
                                }
                            }
                        }
                    }
                }.resume()
            }
        }
    }
    
    private func transition(toImage image: UIImage?) {
        UIView.transition(with: self, duration: 0.2,
                          options: [.transitionCrossDissolve],
                          animations: {
            self.image = image
        }, completion: nil)
    }
}

