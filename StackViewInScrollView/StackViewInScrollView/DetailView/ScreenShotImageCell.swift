import UIKit

class ScreenShotImageCell: UICollectionViewCell, ReuseIdentiable {
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
        
        layer.cornerRadius = 10
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray6.cgColor
    }
    
    func load(with urlString: String) {
        imageView.setImageUrl(urlString)
    }
}
