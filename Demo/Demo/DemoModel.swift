//
//  DemoModel.swift
//  Demo
//
//  Created by Daniel Saidi on 2025-06-19.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import PresentationKit
import SwiftUI

struct DemoModel: Identifiable {

    let id: Int
}

extension FocusedValues {

    @Entry var demoModelAlertContext: AlertContext<DemoModel>?
    @Entry var demoModelCoverContext: FullScreenCoverContext<DemoModel>?
    @Entry var demoModelSheetContext: SheetContext<DemoModel>?
}
