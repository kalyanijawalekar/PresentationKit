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
                Button("Present another full screen cover") {
                    cover.present(value)
                }
                Button("Present another sheet") {
                    sheet.present(value)
                }
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Dismiss", role: .cancel) {
                        dismiss()
                    }
                }
            }
        }
    }
}
