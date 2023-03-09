import ComposableArchitecture
import SwiftUI

public struct SecondTabFeature: ReducerProtocol {
    public struct State: Equatable {}
    
    public enum Action: Equatable {
        case goSettingButtonTapped
        case delegate(Delegate)
    }
    
    public enum Delegate: Equatable {
        case switchSettingTab
    }
    
    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .goSettingButtonTapped:
            return .send(.delegate(.switchSettingTab))
            
        case .delegate:
            return .none
        }
    }
}

struct SecondTabView: View {
    
    let store: StoreOf<SecondTabFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Button {
                viewStore.send(.goSettingButtonTapped)
            } label: {
                Text("설정화면 이동")
            }
        }
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondTabView(store: .init(
            initialState: SecondTabFeature.State(),
            reducer: SecondTabFeature())
        )
    }
}
