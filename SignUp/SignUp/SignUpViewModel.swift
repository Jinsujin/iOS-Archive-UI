import Foundation
import Combine

class SignUpViewModel {
    
    @Published var idInput: String = ""
    
    // @Published 어노테이션으로 구독 가능한 저장속성이라는 것을 명시
    @Published var passwordInput: String = "" {
        // didSet 을 사용해 들어오는 값에 대한 디버깅도 가능
        didSet {
            print("SignUpViewModel.passwordInput: \(passwordInput)")
        }
    }
    @Published var passwordConfirmInput: String = ""
    
    /// 패스워드, 패스워드 확인의 값이 일치하는지 확인받는 퍼블리셔
    // CombineLatest: 두 Publisher 의 최근 값을 받아서 처리
    // 에러는 방출하지 않지 때문에 Never
    lazy var isMatchPasswordPublisher: AnyPublisher<Bool, Never> = Publishers
        .CombineLatest3($idInput, $passwordInput, $passwordConfirmInput)
        .map({ (id: String, password: String, passwordConfirm: String) in
            if (id == "" || password == "" || passwordConfirm == "") {
                return false
            }
            if (password == passwordConfirm) {
                return true
            }
            return false
        })
        .print()
        .eraseToAnyPublisher() // AnyPublisher 형태로 만들기 위해 사용
    
    
    lazy var isMat = Publishers
        .CombineLatest($passwordInput, $passwordConfirmInput)
        .map({ (password: String, passwordConfirm: String) in
            if (password == "" || passwordConfirm == "") {
                return false
            }
            if password == passwordConfirm {
                return true
            }
            return false
        })
}
