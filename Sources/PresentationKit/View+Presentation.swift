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
    func presentation<Model: Identifiable, AlertActions: View, AlertMessage: View>(
        for model: Model.Type,
        alertContent: @escaping (Model) -> AlertContent<AlertActions, AlertMessage>
    ) -> some View {
        self.modifier(
            PresentationModifier(
                alertContent: alertContent,
                coverContent: { _ in EmptyView() },
                sheetContent: { _ in EmptyView() }
            )
        )
    }

    /// Register a presentation strategy for a certain model,
    /// with the same view for full screen covers and sheets.
    func presentation<Model: Identifiable, AlertActions: View, AlertMessage: View, ModalContent: View>(
        for model: Model.Type,
        alertContent: @escaping (Model) -> AlertContent<AlertActions, AlertMessage>,
        modalContent: @escaping (Model) -> ModalContent
    ) -> some View {
        self.modifier(
            PresentationModifier(
                alertContent: alertContent,
                coverContent: modalContent,
                sheetContent: modalContent
            )
        )
    }

    /// Register a presentation strategy for a certain model.
    func presentation<Model: Identifiable, AlertActions: View, AlertMessage: View, CoverContent: View, SheetContent: View>(
        for model: Model.Type,
        alertContent: @escaping (Model) -> AlertContent<AlertActions, AlertMessage>,
        coverContent: @escaping (Model) -> CoverContent,
        sheetContent: @escaping (Model) -> SheetContent
    ) -> some View {
        self.modifier(
            PresentationModifier(
                alertContent: alertContent,
                coverContent: coverContent,
                sheetContent: sheetContent
            )
        )
    }

    /// Register a presentation strategy for a certain model,
    /// with the same view for full screen covers and sheets.
    func presentation<Model: Identifiable, ModalContent: View>(
        for model: Model.Type,
        modalContent: @escaping (Model) -> ModalContent
    ) -> some View {
        self.modifier(
            PresentationModifier(
                alertContent: { _ in AlertContent.empty() },
                coverContent: modalContent,
                sheetContent: modalContent
            )
        )
    }

    /// Register a presentation strategy for a certain model.
    func presentation<Model: Identifiable, CoverContent: View, SheetContent: View>(
        for model: Model.Type,
        coverContent: @escaping (Model) -> CoverContent,
        sheetContent: @escaping (Model) -> SheetContent
    ) -> some View {
        self.modifier(
            PresentationModifier(
                alertContent: { _ in AlertContent.empty() },
                coverContent: coverContent,
                sheetContent: sheetContent
            )
        )
    }
}

struct PresentationModifier<Model: Identifiable, AlertActions: View, AlertMessage: View, CoverContent: View, SheetContent: View>: ViewModifier {

    init(
        alertContent: @escaping (Model) -> AlertContent<AlertActions, AlertMessage>,
        coverContent: @escaping (Model) -> CoverContent,
        sheetContent: @escaping (Model) -> SheetContent
    ) {
        self.alertContent = alertContent
        self.coverContent = coverContent
        self.sheetContent = sheetContent
    }

    let alertContent: (Model) -> AlertContent<AlertActions, AlertMessage>
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
                actions: { alertContent($0).actions },
                message: { alertContent($0).message }
            )
            .fullScreenCover(item: $coverContext.value, content: cover)
            .sheet(item: $sheetContext.value, content: sheet)
    }
}

private extension PresentationModifier {

    var alertTitle: LocalizedStringKey {
        guard let val = alertContext.value else { return "" }
        return alertContent(val).title
    }

    func cover(for value: Model) -> some View {
        coverContent(value)
            .presentation(
                for: Model.self,
                alertContent: alertContent,
                coverContent: coverContent,
                sheetContent: sheetContent
            )
    }

    func sheet(for value: Model) -> some View {
        sheetContent(value)
            .presentation(
                for: Model.self,
                alertContent: alertContent,
                coverContent: coverContent,
                sheetContent: sheetContent
            )
    }
}
