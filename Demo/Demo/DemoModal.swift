//
//  DemoModal.swift
//  Demo
//
//  Created by Daniel Saidi on 2025-06-19.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import PresentationKit
import SwiftUI

struct DemoModal: View {

    let value: DemoModel
    let title: String

    @Environment(\.dismiss) private var dismiss

    @Environment(AlertContext<DemoModel>.self) private var alert
    @Environment(FullScreenCoverContext<DemoModel>.self) private var cover
    @Environment(SheetContext<DemoModel>.self) private var sheet

    var body: some View {
        NavigationStack {
            List {
                Button("Present another alert") {
                    alert.present(value)
                }
                #if !os(macOS)
                Button("Present another full screen cover") {
                    cover.present(value)
                }
                #endif
                Button("Present another sheet") {
                    sheet.present(value)
                }
            }
            .frame(minHeight: 250)
            .focusable()
            .focusedValue(\.demoModelAlertContext, alert)
            .focusedValue(\.demoModelCoverContext, cover)
            .focusedValue(\.demoModelSheetContext, sheet)
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Dismiss", role: .cancel) {
                        dismiss()
                    }
                }
            }
        }
    }
}
