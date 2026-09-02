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
