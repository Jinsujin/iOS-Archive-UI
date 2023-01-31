import UIKit

class CarouselViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViews()
        
        prevButton.addAction(UIAction(handler: { action in
            print("touch prev")
        }), for: .touchUpInside)
        
        nextButton.addAction(UIAction(handler: { action in
            print("touch next")
        }), for: .touchUpInside)
    }
    
    private func setupViews() {
        let contentView = UIImageView(image: UIImage(named: "1"))
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentView)
        contentView.backgroundColor = .orange
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        view.addSubview(prevButton)
        NSLayoutConstraint.activate([
            prevButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            prevButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40)
        ])
        
        view.addSubview(nextButton)
        NSLayoutConstraint.activate([
            nextButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nextButton.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40)
        ])
    }
    
    private let prevButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "arrowtriangle.left.fill"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let nextButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "arrowtriangle.right.fill"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
}
