//
//  Contexts.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2025-06-19.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This type can be used to present alerts.
///
/// EnvironmentKit will create and inject a context instance
/// when you apply a `.presentation(for: ...)` view modifier.
@Observable
public class AlertContext<Model: Identifiable> {

    /// The value to present.
    public var value: Model?

    /// Present the provided value.
    public func present(_ value: Model) {
        self.value = value
    }
}

/// This type can be used to present full screen covers.
///
/// EnvironmentKit will create and inject a context instance
/// when you apply a `.presentation(for: ...)` view modifier.
@Observable
public class FullScreenCoverContext<Model: Identifiable> {

    /// The value to present.
    public var value: Model?

    /// Present the provided value.
    public func present(_ value: Model) {
        self.value = value
    }
}

/// This type can be used to manage sheet presentation state.
///
/// EnvironmentKit will create and inject a context instance
/// when you apply a `.presentation(for: ...)` view modifier.
@Observable
public class SheetContext<Model: Identifiable> {

    /// The value to present.
    public var value: Model?

    /// Present the provided value.
    public func present(_ value: Model) {
        self.value = value
    }
}
