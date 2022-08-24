//
//  ContentView.swift
//  testing-images
//
//  Created by Alex Little on 23/08/2022.
//

import SwiftUI
import ComposableArchitecture

struct ChildView: View {
  let store: StoreOf<Child>

  var body: some View {
    WithViewStore(store.scope(state: \.color)) { viewStore in
      ZStack {
        Color(uiColor: viewStore.state)
          .frame(width: 10, height: 10)
      }
      .onAppear {
        viewStore.send(.onAppear)
      }
      .onDisappear {
        viewStore.send(.onDisappear)
      }
    }
  }
}

struct ContentView: View {
  let store: StoreOf<Seven>

  var body: some View {
    List {
      ForEachStore(store.scope(state: \.children, action: Seven.Action.child)) { childStore in
        ChildView(store: childStore)
      }
    }
  }
}
