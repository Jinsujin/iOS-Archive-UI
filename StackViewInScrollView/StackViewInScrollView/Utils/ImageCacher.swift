import UIKit

class ImageCacher {
    static let shared = NSCache<NSString, UIImage>()
}

extension UIImageView {
    func setImageUrl(_ urlString: String) {
        let cacheKey = NSString(string: urlString)
        if let cachedImage = ImageCacher.shared.object(forKey: cacheKey) {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let _ = error {
                    DispatchQueue.main.async {
                        self.image = UIImage()
                    }
                    return
                }
                guard let data = data, let image = UIImage(data: data) else {
                    return
                }
                
                DispatchQueue.main.async {
                    ImageCacher.shared.setObject(image, forKey: cacheKey)
                    self.image = image
                }
            }.resume()
        }
    }
}
