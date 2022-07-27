//
//  UIImageView+Foundation.swift
//  BF_Test
//
//  Created by mino on 2022/07/27.
//

import UIKit
import Alamofire
import AlamofireImage

extension UIImageView {
    
    func setImage(url: URL, placeholder: UIImage? = nil) {
        self.image = placeholder
        
        let urlRequest =  URLRequest(url: url)
        
        if let image = UIImage.imageCache.image(for:urlRequest) {
            self.image = image
            return
        }
        
        AF.request(urlRequest).responseImage { response in
            guard let image = response.value else {
                return
            }
            
            UIImage.imageCache.add(image, for: urlRequest)
            
            self.image = image
        }
    }
}

