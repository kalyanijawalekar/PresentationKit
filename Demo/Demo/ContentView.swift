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

    @Environment(AlertContext<DemoModel>.self) private var alert
    @Environment(FullScreenCoverContext<DemoModel>.self) private var cover
    @Environment(SheetContext<DemoModel>.self) private var sheet

    private let value = DemoModel(id: 1)

    var body: some View {
        NavigationStack {
            List {
                Button("Present an alert") {
                    alert.present(value)
                }
                Button("Present a full screen cover") {
                    cover.present(value)
                }
                Button("Present a sheet") {
                    sheet.present(value)
                }
            }
            .navigationTitle("Demo")
        }
    }
}

#Preview {
    ContentView()
}
