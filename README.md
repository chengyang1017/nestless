# nestless_flutter

Keep common Flutter UI code shallow and readable.

`nestless_flutter` does not replace Flutter's widget tree. Its preferred API
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

The extension form directly creates Flutter's `Column`, `Padding`, and
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

Use iterable extensions when Flutter already owns the underlying layout
concept.

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

### Stack

```dart
<Widget>[
  Image.network(
    imageUrl,
    fit: BoxFit.cover,
  ),
  const Text(
    'NEW',
    style: TextStyle(
      fontWeight: FontWeight.bold,
    ),
  ).nPositioned(
    top: 12,
    right: 12,
  ),
].nStack(
  width: 320,
  height: 180,
  clipBehavior: Clip.antiAlias,
);
```

`nStack()` directly returns Flutter's `Stack`. Positioning can stay in the
normal modifier chain with `nPositioned()`.

### Wrap

```dart
<Widget>[
  const Chip(label: Text('Flutter')),
  const Chip(label: Text('Dart')),
  const Chip(label: Text('Firebase')),
  const Chip(label: Text('PostgreSQL')),
  const Chip(label: Text('Nestless')),
].nWrap(
  spacing: 8,
  runSpacing: 8,
);
```

`nWrap()` directly returns Flutter's `Wrap`.

`NColumn`, `NRow`, `NGrid`, `NStack`, and `NWrap` remain available for
compatibility, but new code should prefer the extension-first form.

## Scrolling by composition

When scrolling is just another Flutter wrapper, compose it instead of creating
a second layout vocabulary.

```dart
[
  const Text(
    'Settings',
    style: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
  ),
  const Text('Account'),
  const Text('Privacy'),
  const Text('Notifications'),
  FilledButton(
    onPressed: save,
    child: const Text('Save changes'),
  ),
]
    .nColumn(
      gap: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
    )
    .nPadAll(24)
    .nScrollY()
    .nWidth(480);
```

That produces normal Flutter widgets:

```text
SizedBox
└── SingleChildScrollView
    └── Padding
        └── Column
```

Horizontal scrolling works the same way:

```dart
<Widget>[
  const Chip(label: Text('Flutter')),
  const Chip(label: Text('Dart')),
  const Chip(label: Text('Firebase')),
  const Chip(label: Text('PostgreSQL')),
]
    .nRow(gap: 8)
    .nScrollX();
```

`NScrollColumn` and `NScrollRow` remain available as compatibility widgets,
but internally they compose the same extension-first primitives.

## Box and wrapper modifiers

For ordinary wrapper behavior, prefer modifiers over a dedicated box class:

```dart
const Text('Error')
    .nAlign(Alignment.centerLeft)
    .nPadAll(16)
    .nWidth(480);
```

For several container-style properties at once, use `nBox()`:

```dart
const Text('Premium').nBox(
  width: 320,
  padding: const EdgeInsets.all(16),
  margin: const EdgeInsets.only(bottom: 12),
  alignment: Alignment.center,
  decoration: const BoxDecoration(
    borderRadius: BorderRadius.all(
      Radius.circular(16),
    ),
  ),
);
```

`nBox()` directly returns Flutter's `Container` when a wrapper is needed.
`NBox` remains available for compatibility.

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

For a small, already-built list of widgets:

```dart
CustomScrollView(
  slivers: [
    <Widget>[
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

For a long or dynamic list, use the lazy builder form so only visible items are
built:

```dart
CustomScrollView(
  slivers: [
    NSliverColumn.builder(
      itemCount: messages.length,
      gap: 12,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final message = messages[index];

        return ListTile(
          leading: CircleAvatar(
            child: Text(message.authorInitial),
          ),
          title: Text(message.authorName),
          subtitle: Text(message.text),
        );
      },
    ),
  ],
);
```

`NSliverColumn.builder` uses Flutter's `SliverChildBuilderDelegate`. Gaps are
also created lazily instead of expanding the full list before layout.

For a small fixed-column sliver grid:

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

For a large fixed-column grid, use the builder form:

```dart
CustomScrollView(
  slivers: [
    NSliverGrid.builder(
      columns: 3,
      itemCount: products.length,
      gap: 12,
      rowGap: 16,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final product = products[index];

        return Card(
          child: Column(
            children: [
              Expanded(
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(product.name),
              ),
            ],
          ),
        );
      },
    ),
  ],
);
```

For a small responsive sliver grid:

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

For a large responsive grid, combine automatic column calculation with lazy
item construction:

```dart
CustomScrollView(
  slivers: [
    NSliverResponsiveGrid.builder(
      minItemWidth: 220,
      maxColumns: 5,
      itemCount: products.length,
      gap: 16,
      rowGap: 16,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final product = products[index];

        return Card(
          child: Column(
            children: [
              Expanded(
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(product.name),
              ),
            ],
          ),
        );
      },
    ),
  ],
);
```

`NSliverResponsiveGrid.builder` uses the same viewport-width calculation as the
normal responsive grid, then forwards the item builder to a lazy
`SliverChildBuilderDelegate`.

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
Iterable<Widget> -> nStack()  -> Stack
Iterable<Widget> -> nWrap()   -> Wrap
Widget           -> nPadAll() -> Padding
Widget           -> nScrollY()-> SingleChildScrollView
Widget           -> nWidth()  -> SizedBox
Widget           -> nBox()    -> Container
```

Keep dedicated Nestless widgets for behavior that adds a higher-level concept,
such as responsive layout switching, responsive column calculation, or lazy
sliver composition.

## Design rules

- Prefer normal Flutter widgets as the runtime output.
- Use extensions to reduce source-code nesting without hiding Flutter concepts.
- Keep modifier chains short.
- Preserve normal Flutter Inspector and DevTools output.
- Keep dedicated `N...` widgets only when they add meaningful higher-level behavior.
- Use builder delegates for large sliver datasets instead of eagerly constructing widget lists.
- Avoid one giant widget with dozens of unrelated flags.
- Mix Nestless and ordinary Flutter widgets freely.
