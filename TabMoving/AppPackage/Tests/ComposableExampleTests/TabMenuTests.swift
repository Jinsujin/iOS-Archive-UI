import ComposableArchitecture
import XCTest

@testable import ComposableExample

/**
 - Store class 는 thread-safe 하지 않다.
 - 테스트를 main thread 에서 동작하게 하기 위해 @MainActor 를 사용
 */
@MainActor
final class TabMenuTests: XCTestCase {

    func testMoveSettingTab() async {
        let store = TestStore(
            initialState: RootFeature.State(),
            reducer: RootFeature()
        )
        
        // NOTE: - delegate 적용 전 테스트
//        await store.send(.secondTab(.goInventoryButtonTapped)) {
//            $0.activeMenu = .settings
//        }
        
        // NOTE: - delegate 적용 후 테스트
        await store.send(.secondTab(.goSettingButtonTapped))
        await store.receive(.secondTab(.delegate(.switchSettingTab))) {
            $0.activeMenu = .settings
        }
    }
}
