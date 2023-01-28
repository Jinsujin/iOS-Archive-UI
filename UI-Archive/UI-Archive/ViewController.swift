import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func touchedCarouselButton(_ sender: Any) {
        let viewController = CarouselViewController()
        present(viewController, animated: false)
    }
    
}

