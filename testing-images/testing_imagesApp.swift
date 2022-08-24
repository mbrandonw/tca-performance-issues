//
//  testing_imagesApp.swift
//  testing-images
//
//  Created by Alex Little on 23/08/2022.
//

import SwiftUI
import ComposableArchitecture

@main
struct testing_imagesApp: SwiftUI.App {
  let store = Store(
    initialState: App.State(),
    reducer: App()//.debugActions(actionFormat: .labelsOnly)
  )
  var body: some Scene {
    WindowGroup {
      MidView(
        store: store.scope(state: \.one, action: App.Action.one),
        content: { store in
          MidView(
            store: store.scope(state: \.two, action: One.Action.two),
            content: { store in
              MidView(
                store: store.scope(state: \.three, action: Two.Action.three),
                content: { store in
                  MidView(
                    store: store.scope(state: \.four, action: Three.Action.four),
                    content: { store in
                      MidView(
                        store: store.scope(state: \.five, action: Four.Action.five),
                        content: { store in
                          MidView(
                            store: store.scope(state: \.six, action: Five.Action.six),
                            content: { store in
                              ContentView(store: store.scope(state: \.seven, action: Six.Action.seven))
                            }
                          )
                        }
                      )
                    }
                  )
                }
              )
            }
          )
        }
      )
    }
  }
}

struct MidView<State: Equatable, Action: Equatable, Content: View>: View {
  let store: Store<State, Action>
  let content: Content

  init(store: Store<State, Action>, @ViewBuilder content: (Store<State, Action>) -> Content) {
    self.store = store
    self.content = content(store)
  }

  var body: some View {
    content
  }
}
