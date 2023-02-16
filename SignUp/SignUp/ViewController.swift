import UIKit
import Combine

class ViewController: UIViewController {
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    private var viewModel: SignUpViewModel!
    private var subscriptions = Set<AnyCancellable>()
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = SignUpViewModel()
        
        idTextField
            .textPublisher
            .assign(to: \.idInput, on: viewModel)
            .store(in: &subscriptions)
        
        // TextField 에서 방출되는 이벤트를 ViewModel.passwordInput 이 구독
        passwordTextField
            .textPublisher
            .print()
            .receive(on: DispatchQueue.main) // 스케쥴러는 스레드를 설정하는 것
            .assign(to: \.passwordInput, on: viewModel) // KVO 방식으로 구독해서 값을 받는다 => 받아온 값을 viewModel 의 passwordInput 으로 전달된다
            .store(in: &subscriptions) // 구독을 하고나면 자료형이 AnyCancellable
        
        passwordConfirmTextField
            .textPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.passwordConfirmInput, on: viewModel)
            .store(in: &subscriptions)
        
        // ViewModel.isMatch Publisher 가 이벤트를 방출하면 -> 버튼(UI) 이 구독
        // isMatch 에서 값이 방출될때마다 signUpButton.isValid 값이 변경
        viewModel.isMatchPasswordPublisher
            .receive(on: RunLoop.main) // 다른 쓰레드와 같이 작업할때 RunLoop 로 돌린다
            .assign(to: \.isValid, on: signUpButton)
            .store(in: &subscriptions)
    }
}

extension UITextField {

    // 클로저로 퍼블리셔를 가져온다
    var textPublisher: AnyPublisher<String, Never> {
        // 1. textfield 의 text 가 변경되었을때 (textDidChangeNotification) 이벤트 방출
        // 2. 방출된 object 를 UITextField 로 타입 캐스팅
        // 3. textfield 의 text 만 가져오기 위해 연산자연결
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap{ $0.object as? UITextField }
            .map { $0.text ?? "" }
            .print() // 디버깅
            .eraseToAnyPublisher()
    }
}

extension UIButton {
    var isValid: Bool {
        get {
            backgroundColor == .lightGray
        }
        set {
            backgroundColor = newValue ? .blue : .lightGray
            isEnabled = newValue
            setTitleColor(newValue ? .white : .black, for: .normal)
        }
    }
}
