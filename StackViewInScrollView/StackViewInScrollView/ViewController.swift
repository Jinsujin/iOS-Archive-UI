import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let vc = DetailViewController.instantiateFromNib(with: Entity.mock)
        self.present(vc, animated: true)
    }
}

