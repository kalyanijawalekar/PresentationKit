//
//  View+Presentation.swift
//  PresentationKit
//
//  Created by Daniel Saidi on 2025-06-19.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {

    /// Register a presentation strategy for a certain model.
    ///
    /// The view modifier will create and inject new context
    /// values for the view and repeat it for any new modals.
    func presentation<Model: Identifiable, AlertActions: View, AlertMessage: View, CoverContent: View, SheetContent: View>(
        for model: Model.Type,
        alertTitle: LocalizedStringKey,
        alertActions: @escaping (Model) -> AlertActions,
        alertMessage: @escaping (Model) -> AlertMessage,
        coverContent: @escaping (Model) -> CoverContent,
        sheetContent: @escaping (Model) -> SheetContent
    ) -> some View {
        self.modifier(
            PresentationModifier(
                alertTitle: alertTitle,
                alertActions: alertActions,
                alertMessage: alertMessage,
                coverContent: coverContent,
                sheetContent: sheetContent
            )
        )
    }
}

struct PresentationModifier<Model: Identifiable, AlertActions: View, AlertMessage: View, CoverContent: View, SheetContent: View>: ViewModifier {

    init(
        alertTitle: LocalizedStringKey,
        alertActions: @escaping (Model) -> AlertActions,
        alertMessage: @escaping (Model) -> AlertMessage,
        coverContent: @escaping (Model) -> CoverContent,
        sheetContent: @escaping (Model) -> SheetContent
    ) {
        self.alertTitle = alertTitle
        self.alertActions = alertActions
        self.alertMessage = alertMessage
        self.coverContent = coverContent
        self.sheetContent = sheetContent
    }

    let alertTitle: LocalizedStringKey
    let alertActions: (Model) -> AlertActions
    let alertMessage: (Model) -> AlertMessage
    let coverContent: (Model) -> CoverContent
    let sheetContent: (Model) -> SheetContent

    @State var alertContext = AlertContext<Model>()
    @State var coverContext = FullScreenCoverContext<Model>()
    @State var sheetContext = SheetContext<Model>()

    public func body(content: Content) -> some View {
        content
            .environment(alertContext)
            .environment(coverContext)
            .environment(sheetContext)
            .alert(
                alertTitle,
                isPresented: .init(
                    get: { alertContext.value != nil },
                    set: {
                        if $0 {
                        } else {
                            alertContext.value = nil
                        }
                    }
                ),
                presenting: alertContext.value,
                actions: alertActions,
                message: alertMessage
            )
            .fullScreenCover(item: $coverContext.value, content: cover)
            .sheet(item: $sheetContext.value, content: sheet)
    }
}

private extension PresentationModifier {

    func cover(for value: Model) -> some View {
        coverContent(value)
            .presentation(
                for: Model.self,
                alertTitle: alertTitle,
                alertActions: alertActions,
                alertMessage: alertMessage,
                coverContent: coverContent,
                sheetContent: sheetContent
            )
    }

    func sheet(for value: Model) -> some View {
        sheetContent(value)
            .presentation(
                for: Model.self,
                alertTitle: alertTitle,
                alertActions: alertActions,
                alertMessage: alertMessage,
                coverContent: coverContent,
                sheetContent: sheetContent
            )
    }
}
