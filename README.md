# nestless_flutter

Keep common Flutter UI code shallow and readable.

`nestless_flutter` does not replace Flutter's Widget tree. Its preferred API
adds concise composition helpers around normal Flutter widgets so the runtime
tree remains familiar in Flutter Inspector and DevTools.

## Goal

Most common `build()` methods should stay within roughly one to three visible
nesting levels while still producing standard Flutter widgets.

## Before

```dart
return SizedBox(
  width: 480,
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Profile',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        const Text('This is the profile description.'),
        const SizedBox(height: 12),
        FilledButton(
          onPressed: save,
          child: const Text('Save'),
        ),
      ],
    ),
  ),
);
```

## After

```dart
return [
  const Text(
    'Profile',
    style: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
  ),
  const Text('This is the profile description.'),
  FilledButton(
    onPressed: save,
    child: const Text('Save'),
  ),
]
    .nColumn(
      gap: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
    )
    .nPadAll(16)
    .nWidth(480);
```

The extension form above directly creates Flutter's `Column`, `Padding`, and
`SizedBox`. It does not add an `NColumn` wrapper to the runtime tree.

## Local installation

```yaml
dependencies:
  nestless_flutter:
    path: ../nestless_flutter
```

## Import

```dart
import 'package:nestless_flutter/nestless_flutter.dart';
```

## Extension-first layouts

Use iterable extensions when Flutter already has the underlying layout widget.

### Column

```dart
[
  const Text('Account'),
  const Text('lim@example.com'),
  FilledButton(
    onPressed: save,
    child: const Text('Save'),
  ),
]
    .nColumn(
      gap: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
    )
    .nPadAll(16)
    .nWidth(480);
```

`nColumn()` directly returns Flutter's `Column` plus any requested normal
Flutter wrappers.

### Row

```dart
[
  const CircleAvatar(
    child: Text('L'),
  ),
  const Text('Lim Cheng Yang').nExpanded(),
  IconButton(
    onPressed: openMenu,
    icon: const Icon(Icons.more_vert),
  ),
]
    .nRow(gap: 12)
    .nPadSymmetric(horizontal: 16, vertical: 8);
```

`nRow()` directly returns Flutter's `Row`.

### Grid

```dart
[
  const Card(child: Center(child: Text('A'))),
  const Card(child: Center(child: Text('B'))),
  const Card(child: Center(child: Text('C'))),
  const Card(child: Center(child: Text('D'))),
].nGrid(
  columns: 2,
  gap: 12,
  rowGap: 16,
  childAspectRatio: 1.2,
);
```

`nGrid()` directly returns Flutter's `GridView`.

The `NColumn`, `NRow`, and `NGrid` widget classes remain available for
compatibility, but new code should prefer the extension-first form.

## Responsive grid

Use `NResponsiveGrid` when Nestless adds behavior that Flutter does not expose
as one direct widget: deriving the column count from the available width.

```dart
NResponsiveGrid(
  minItemWidth: 220,
  maxColumns: 5,
  gap: 16,
  children: const [
    Card(child: Center(child: Text('A'))),
    Card(child: Center(child: Text('B'))),
    Card(child: Center(child: Text('C'))),
  ],
);
```

The iterable API is available too:

```dart
cards.nResponsiveGrid(
  minItemWidth: 220,
  gap: 16,
);
```

## Sliver layouts

Use Nestless sliver helpers when the combination itself removes substantial
Flutter sliver boilerplate.

```dart
CustomScrollView(
  slivers: [
    [
      const Text('Overview'),
      const Text('Recent activity'),
      FilledButton(
        onPressed: refresh,
        child: const Text('Refresh'),
      ),
    ].nSliverColumn(
      gap: 12,
      padding: const EdgeInsets.all(16),
    ),
  ],
);
```

For a fixed-column sliver grid:

```dart
CustomScrollView(
  slivers: [
    cards.nSliverGrid(
      columns: 3,
      gap: 12,
      rowGap: 16,
      padding: const EdgeInsets.all(16),
    ),
  ],
);
```

For a responsive sliver grid:

```dart
CustomScrollView(
  slivers: [
    cards.nSliverResponsiveGrid(
      minItemWidth: 220,
      maxColumns: 5,
      gap: 16,
      padding: const EdgeInsets.all(16),
    ),
  ],
);
```

## Responsive layout switching

Use `NResponsive` when the layout structure itself should change by width:

```dart
NResponsive(
  mobile: const MobilePage(),
  tablet: const TabletPage(),
  desktop: const DesktopPage(),
);
```

The default breakpoints are mobile below 600, tablet from 600 to 1023, and
desktop from 1024 upward. They can be customized:

```dart
NResponsive(
  breakpoints: const NBreakpoints(
    tablet: 720,
    desktop: 1200,
  ),
  mobile: const MobilePage(),
  tablet: const TabletPage(),
  desktop: const DesktopPage(),
);
```

For local decisions inside an existing widget tree, use the `BuildContext`
extensions:

```dart
context.nBreakpoint();
context.nIsMobile;
context.nIsTablet;
context.nIsDesktop;
context.nWidth;
```

## Short modifier chains

Use modifiers for one to three simple wrappers:

```dart
const Text('Error')
    .nAlign(Alignment.centerLeft)
    .nPadAll(16)
    .nWidth(480);
```

The first method becomes the inner wrapper. The last method becomes the outer
wrapper.

## API direction

Prefer extension-first APIs when Flutter already owns the concept:

```text
Iterable<Widget> -> nColumn() -> Column
Iterable<Widget> -> nRow()    -> Row
Iterable<Widget> -> nGrid()   -> GridView
Widget           -> nPadAll() -> Padding
Widget           -> nWidth()  -> SizedBox
```

Keep dedicated Nestless widgets for behavior that adds a higher-level concept,
such as responsive layout switching or responsive column calculation.

## Design rules

- Prefer normal Flutter widgets as the runtime output.
- Use extensions to reduce source-code nesting without hiding Flutter concepts.
- Keep modifier chains short.
- Preserve normal Flutter Inspector and DevTools output.
- Keep dedicated `N...` widgets only when they add meaningful higher-level behavior.
- Avoid one giant widget with dozens of unrelated flags.
- Mix Nestless and ordinary Flutter widgets freely.
