# ``PresentationKit``

A SwiftUI library that makes it easy to present alerts and modal content.

## Overview

![Library logotype](Logo.png)

PresentationKit is a SwiftUI library that makes it easy to present alerts, sheets, and full screen covers for any identifiable model, by using observable ``AlertContext``, ``FullScreenCoverContext``, and ``SheetContext`` classes.

PresentationKit lets you register a presentation strategy for any identifiable model, and will create and inject unique context values into the environment for each modal layer. This lets you use the current contexts to present new content from any view.



## Installation

PresentationKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/PresentationKit.git
```



## Supported Platforms

PresentationKit supports iOS 17, tvOS 17, macOS 14, watchOS 10, and visionOS 1.



## Support My Work

You can [become a sponsor][Sponsors] to help me dedicate more time on my various [open-source tools][OpenSource]. Every contribution, no matter the size, makes a real difference in keeping these tools free and actively developed.



## Getting Started

To use PresentationKit, just apply any of the available `.presentation(for: ...)` view modifiers to your application root, then use the environment injected ``AlertContext``, ``FullScreenCoverContext``, and ``SheetContext`` to present alerts and modals.

For instance, consider that we have the following, super-simple type, which in a real world app could be a complex model, an error type, a screen-defining enum, or any type that you want to present:

```swift
struct Model: Identifiable {

    let id: Int
}
```

All we have to do to be able to present this type in an alert, full screen cover, or sheet is to define a presentation strategy for it like this:

```swift
@main
struct MyApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
                .presentation(
                    for: Model.self,
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
                        ModalView(value: $0, title: "Cover") 
                    },
                    sheetContent: { 
                        ModalView(value: $0, title: "Sheet")
                    }
                )
        }
    }
}
```

You can omit any builder that you're not going to use. To only alert errors, you only have to provide an alert content builder, and to only present modals, you only have to provide a modal content builder.

The ContentView, and all views in its view hierarchy, can now present Model values with the various context ``PresentationContext/present(_:)`` functions:

```swift
struct ContentView: View {

    @Environment(AlertContext<Model>.self) private var alert
    @Environment(FullScreenCoverContext<Model>.self) private var cover
    @Environment(SheetContext<Model>.self) private var sheet

    private let value = Model(id: 1)

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
```

PresentationKit will apply the same presentation strategy to all modals, using new context values, which means that this will also work:

```swift
struct ModalView: View {

    let value: Model
    let title: String

    @Environment(\.dismiss) private var dismiss

    @Environment(AlertContext<Model>.self) private var alert
    @Environment(FullScreenCoverContext<Model>.self) private var cover
    @Environment(SheetContext<Model>.self) private var sheet

    private let value = Model(id: 2)

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
```

In other words, you only have to specify your presentation strategy *once*, after which the same presentations will work in the entire app.



## Demo Application

The [project repository][Project] has a demo app that lets you explore the library.



## Repository

For more information, source code, etc., visit the [project repository][Project].



## License

PresentationKit is available under the MIT license.



## Topics

### Essentials

- ``VideoPlayer``
- ``VideoPlayerController``

### Video Splash Screen

- ``VideoSplashScreenConfiguration``
- ``VideoSplashScreenViewModifier``

### Videos

- ``SampleVideo``



[Email]: mailto:daniel.saidi@gmail.com
[Website]: https://danielsaidi.com
[GitHub]: https://github.com/danielsaidi
[OpenSource]: https://danielsaidi.com/opensource
[Sponsors]: https://github.com/sponsors/danielsaidi

[Project]: https://github.com/danielsaidi/PresentationKit
