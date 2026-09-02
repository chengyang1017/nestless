# nestless_flutter

Keep common Flutter UI code shallow and readable.

`nestless_flutter` does not replace Flutter's Widget tree. It keeps the same
runtime widgets while reducing wrapper-heavy source code.

## Goal

Most common `build()` methods should stay within roughly one to three visible
nesting levels.

## Before

```dart
return SizedBox(
  width: 480,
  child: SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          title,
          const SizedBox(height: 12),
          content,
          const SizedBox(height: 12),
          button,
        ],
      ),
    ),
  ),
);
```

## After

```dart
return NScrollColumn(
  width: 480,
  padding: const EdgeInsets.all(16),
  gap: 12,
  children: [
    title,
    content,
    button,
  ],
);
```

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

## Layouts

```dart
NColumn(
  gap: 16,
  children: [
    const Text('Title'),
    TextField(controller: controller),
    FilledButton(
      onPressed: save,
      child: const Text('Save'),
    ),
  ],
);
```

```dart
NRow(
  gap: 12,
  children: [
    const CircleAvatar(),
    const Text('Username').nExpanded(),
    IconButton(
      onPressed: openMenu,
      icon: const Icon(Icons.more_vert),
    ),
  ],
);
```

```dart
NBox(
  width: 320,
  padding: const EdgeInsets.all(16),
  alignment: Alignment.center,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(16),
  ),
  child: content,
);
```

```dart
NGrid(
  columns: 3,
  gap: 12,
  rowGap: 16,
  childAspectRatio: 1.2,
  children: cards,
);
```

An iterable can use the same grid layout through the extension API:

```dart
cards.nGrid(
  columns: 3,
  gap: 12,
);
```

For responsive grids, provide a minimum item width instead of breakpoints:

```dart
NResponsiveGrid(
  minItemWidth: 220,
  maxColumns: 5,
  gap: 16,
  children: cards,
);
```

The number of columns is derived from the available width. The same API is
available on iterables:

```dart
cards.nResponsiveGrid(
  minItemWidth: 220,
  gap: 16,
);
```

## Sliver layouts

Use `NSliverColumn` directly inside `CustomScrollView.slivers` when the page
needs normal Flutter sliver behavior without the usual `SliverPadding` and
`SliverChildListDelegate` boilerplate:

```dart
CustomScrollView(
  slivers: [
    NSliverColumn(
      gap: 12,
      padding: const EdgeInsets.all(16),
      children: [
        title,
        content,
        button,
      ],
    ),
  ],
);
```

The iterable extension is available too:

```dart
CustomScrollView(
  slivers: [
    children.nSliverColumn(
      gap: 12,
      padding: const EdgeInsets.all(16),
    ),
  ],
);
```

Use `NSliverGrid` for fixed-column grids inside the same sliver tree:

```dart
CustomScrollView(
  slivers: [
    NSliverGrid(
      columns: 3,
      gap: 12,
      rowGap: 16,
      padding: const EdgeInsets.all(16),
      children: cards,
    ),
  ],
);
```

The iterable API mirrors `NGrid`:

```dart
cards.nSliverGrid(
  columns: 3,
  gap: 12,
);
```

## Responsive layout switching

Use `NResponsive` when the layout structure itself should change by width:

```dart
NResponsive(
  mobile: mobileLayout,
  tablet: tabletLayout,
  desktop: desktopLayout,
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
  mobile: mobileLayout,
  tablet: tabletLayout,
  desktop: desktopLayout,
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

## Design rules

- Use semantic layout widgets for common combinations.
- Keep modifier chains short.
- Preserve normal Flutter widgets and DevTools output.
- Avoid one giant widget with dozens of unrelated flags.
- Mix Nestless and ordinary Flutter widgets freely.
