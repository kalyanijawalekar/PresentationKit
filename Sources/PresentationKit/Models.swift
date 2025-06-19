//
//  Models.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2025-06-19.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This protocol is implemented by the various presentation
/// context types.
///
/// The library will create a context instance of every type
/// and inject it into the view environment when you apply a
/// `.presentation(for: ...)` view modifier.
public protocol PresentationContext: AnyObject {
    associatedtype Model: Identifiable

    var value: Model? { get set }
}

public extension PresentationContext {

    /// Present the provided value.
    func present(_ value: Model) {
        self.value = value
    }
}

/// This type can be used to present alerts.
@Observable
public class AlertContext<Model: Identifiable>: PresentationContext {

    /// The value to present.
    public var value: Model?
}

/// This type can be used to define alert content.
public struct AlertContent<Actions: View, Message: View> {

    public init(
        title: LocalizedStringKey,
        @ViewBuilder actions: @escaping () -> Actions,
        @ViewBuilder message: @escaping () -> Message
    ) {
        self.title = title
        self.actions = actions
        self.message = message
    }

    public var title: LocalizedStringKey
    public var actions: () -> Actions
    public var message: () -> Message

    static func empty() -> Self where Actions == EmptyView, Message == EmptyView {
        .init(
            title: "",
            actions: { EmptyView() },
            message: { EmptyView() }
        )
    }
}

/// This type can be used to present full screen covers.
@Observable
public class FullScreenCoverContext<Model: Identifiable>: PresentationContext {

    /// The value to present.
    public var value: Model?
}

/// This type can be used to manage sheet presentation state.
@Observable
public class SheetContext<Model: Identifiable>: PresentationContext {

    /// The value to present.
    public var value: Model?
}
