import UIKit


class CarouselViewController: UIViewController {
    
    private var viewModel = CarouselViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViews()
        viewModel.prepare()
        updateContentImage(by: viewModel.currentImageName())
        
        prevButton.addAction(UIAction(handler: { [weak self] action in
            self?.updateContentImage(by: self?.viewModel.prevItem())
        }), for: .touchUpInside)
        
        nextButton.addAction(UIAction(handler: { [weak self] action in
            // 1. 리스트에서 현재 데이터 위치 +1 에 있는 데이터를 가져온다
            // 2-1. 데이터가 없으면: 동작 x (return)
            // 2-2. 데이터가 있으면: 해당 데이터로 현재의 화면 갱신
            self?.updateContentImage(by: self?.viewModel.nextItem())
        }), for: .touchUpInside)
    }
        
    private func updateContentImage(by name: String?) {
        guard let name = name else {
            return
        }
        contentView.image = UIImage(named: name)
    }
    
    private func setupViews() {
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
    
    private let contentView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .orange
        return imageView
    }()
    
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
