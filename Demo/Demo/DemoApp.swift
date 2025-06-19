//
//  DemoApp.swift
//  Demo
//
//  Created by Daniel Saidi on 2025-06-19.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import PresentationKit
import SwiftUI

@main
struct DemoApp: App {

    @FocusedValue(\.demoModelAlertContext) var alert
    @FocusedValue(\.demoModelCoverContext) var cover
    @FocusedValue(\.demoModelSheetContext) var sheet

    var body: some Scene {
        WindowGroup {
            ContentView()
                .presentation(
                    for: DemoModel.self,
                    alertContent: { value in
                        AlertContent(
                            title: "Alert",
                            actions: {
                                Button("OK", action: { print("OK for item #\(value.id)") })
                                Button("Cancel", role: .cancel, action: {})
                            },
                            message: { Text("Alert for item #\(value.id)") }
                        )
                    },
                    coverContent: {
                        DemoModal(value: $0, title: "Cover")
                    },
                    sheetContent: {
                        DemoModal(value: $0, title: "Sheet")
                    }
                )
        }
        .commands {
            CommandMenu("Demo") {
                Button("Present alert") {
                    alert?.present(.init(id: 1))
                }
                .disabled(alert == nil)

                #if !os(macOS)
                Button("Present full screen cover") {
                    cover?.present(.init(id: 2))
                }
                .disabled(cover == nil)
                #endif

                Button("Present sheet") {
                    sheet?.present(.init(id: 3))
                }
                .disabled(sheet == nil)
            }
        }
    }
}
