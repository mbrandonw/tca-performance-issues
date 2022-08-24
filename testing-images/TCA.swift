//
//  TCA.swift
//  testing-images
//
//  Created by Alex Little on 23/08/2022.
//

import Foundation
import ComposableArchitecture
import SwiftUI

let cachedChildren: IdentifiedArrayOf<Child.State> = .init(uniqueElements: (0..<10000).map { .init(id: "\($0)") })

struct App: ReducerProtocol {
  struct State: Equatable {
    var one: One.State = .init()
  }
  enum Action: Equatable {
    case one(One.Action)
  }
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      .none
    }
    Scope(state: \.one, action: /App.Action.one) {
      One()
    }
  }
}

struct One: ReducerProtocol {
  struct State: Equatable {
    var two: Two.State = .init()
  }
  enum Action: Equatable {
    case two(Two.Action)
  }
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      .none
    }
    Scope(state: \.two, action: /Action.two) {
      Two()
    }
  }
}

struct Two: ReducerProtocol {
  struct State: Equatable {
    var three: Three.State = .init()
  }
  enum Action: Equatable {
    case three(Three.Action)
  }
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
        .none
    }
    Scope(state: \.three, action: /Action.three) {
      Three()
    }
  }
}

struct Three: ReducerProtocol {
  struct State: Equatable {
    var four: Four.State = .init()
  }
  enum Action: Equatable {
    case four(Four.Action)
  }
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      .none
    }
    Scope(state: \.four, action: /Action.four) {
      Four()
    }
  }
}

struct Four: ReducerProtocol {
  struct State: Equatable {
    var five: Five.State = .init()
  }
  enum Action: Equatable {
    case five(Five.Action)
  }
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      .none
    }
    Scope(state: \.five, action: /Action.five) {
      Five()
    }
  }
}

struct Five: ReducerProtocol {
  struct State: Equatable {
    var six: Six.State = .init()
  }
  enum Action: Equatable {
    case six(Six.Action)
  }
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      .none
    }
    Scope(state: \.six, action: /Action.six) {
      Six()
    }
  }
}

struct Six: ReducerProtocol {
  struct State: Equatable {
    var seven: Seven.State = .init()
  }
  enum Action: Equatable {
    case seven(Seven.Action)
  }
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      .none
    }
    Scope(state: \.seven, action: /Action.seven) {
      Seven()
    }
  }
}

struct Seven: ReducerProtocol {
  struct State: Equatable {
    var children: IdentifiedArrayOf<Child.State> = cachedChildren
  }
  enum Action: Equatable {
    case child(id: String, action: Child.Action)
  }
  var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
        .none
    }
    .forEach(\.children, action: /Action.child) {
      Child()
    }
  }
}

struct Child: ReducerProtocol {
  struct State: Identifiable, Equatable {
    let id: String
    var color: UIColor = .random
  }
  enum Action: Equatable {
    case onAppear
    case onDisappear
  }

  func reduce(into state: inout State, action: Action) -> Effect<Action, Never> {

    switch action {
    case .onAppear:
      state.color = .random
    case .onDisappear:
      state.color = .random
    }
    return .none
  }
}


extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1
        )
    }
}

