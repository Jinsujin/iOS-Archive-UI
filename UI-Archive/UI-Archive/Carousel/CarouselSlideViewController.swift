import UIKit

class CarouselSlideViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        let imageView1 = UIImageView(image: UIImage(named: "1"))
        let imageView2 = UIImageView(image: UIImage(named: "2"))
        imageView1.translatesAutoresizingMaskIntoConstraints = false
        imageView2.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [
            imageView1,
            imageView2
        ])
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.backgroundColor = .orange
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor)
        ])
        
        let screenWidth = UIScreen.main.bounds.width // 414
        NSLayoutConstraint.activate([
            imageView1.widthAnchor.constraint(equalToConstant: screenWidth),
            imageView1.heightAnchor.constraint(equalToConstant: 200),
            
            imageView2.widthAnchor.constraint(equalTo: imageView1.widthAnchor),
            imageView2.heightAnchor.constraint(equalTo: imageView1.heightAnchor)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // contentSize: (w 828.0, h 200.0)
        // frame: (0.0, 0.0, 414.0, 200.0)
        print("//스크롤 이동전", scrollView.contentOffset)
        scrollView.setContentOffset(CGPoint(x: 414, y: 0), animated: false)
        print("스크롤 이동후//", scrollView.contentOffset) // 414
    }
}
