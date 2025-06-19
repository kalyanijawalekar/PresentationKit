//
//  ContentView.swift
//  Demo
//
//  Created by Daniel Saidi on 2025-06-19.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import PresentationKit
import SwiftUI

struct ContentView: View {

    @Environment(AlertContext<DemoModel>.self) var alert
    @Environment(FullScreenCoverContext<DemoModel>.self) var cover
    @Environment(SheetContext<DemoModel>.self) var sheet

    private let value = DemoModel(id: 1)

    var body: some View {
        NavigationStack {
            List {
                Button("Present an alert") {
                    alert.present(value)
                }
                #if !os(macOS)
                Button("Present a full screen cover") {
                    cover.present(value)
                }
                #endif
                Button("Present a sheet") {
                    sheet.present(value)
                }
            }
            .focusable()
            .focusedValue(\.demoModelAlertContext, alert)
            .focusedValue(\.demoModelCoverContext, cover)
            .focusedValue(\.demoModelSheetContext, sheet)
            .navigationTitle("Demo")
        }
    }
}

#Preview {
    ContentView()
}
