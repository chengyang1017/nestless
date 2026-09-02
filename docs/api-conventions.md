# Nestless API conventions

These conventions keep the public API predictable as the package grows.

## 1. Prefer Flutter runtime widgets

When Flutter already owns the concept, Nestless should reduce source nesting without adding a custom runtime wrapper.

Examples:

```text
nColumn()      -> Column
nRow()         -> Row
nGrid()        -> GridView.count
nGridBuilder() -> GridView.builder
nStack()       -> Stack
nWrap()        -> Wrap
nListBuilder() -> ListView.builder
```

Compatibility `N...` classes may remain for existing callers, but new extension-first APIs should not depend on them internally unless they add meaningful higher-level behavior.

## 2. Keep `N...` widgets for higher-level behavior

A dedicated Nestless widget is appropriate when it owns behavior that is not represented by one direct Flutter widget.

Current examples include:

- `NResponsive`
- `NResponsiveGrid`
- `NSliverResponsiveGrid`
- lazy sliver composition helpers

## 3. Builder parameter order

Builder APIs should present required data in this order:

```dart
itemCount: ...,
itemBuilder: ...,
```

Layout-specific required parameters may appear before them when that reads more naturally, for example `columns` or `minItemWidth`.

## 4. Validation

Use consistent assertions:

```text
itemCount >= 0
columns > 0
minItemWidth > 0
maxColumns == null || maxColumns > 0
gap >= 0
rowGap == null || rowGap >= 0
childAspectRatio > 0
```

Error messages should use the same wording everywhere.

## 5. Spacing

For grids:

```text
gap    -> cross-axis spacing
rowGap -> main-axis spacing
```

If `rowGap` is omitted, it falls back to `gap`.

For linear layouts, `gap` is inserted between children only, never before the first child or after the last child.

## 6. Padding

`padding` belongs to the scrollable/layout being created rather than being emulated with unrelated outer wrappers when Flutter already exposes a native padding argument.

Responsive column calculations must subtract horizontal padding before deriving the column count.

## 7. Lazy vs eager APIs

Use eager iterable APIs for already-built, small widget collections:

```text
nList()
nGrid()
nResponsiveGrid()
nSliverColumn()
nSliverGrid()
nSliverResponsiveGrid()
```

Use builder APIs for large or dynamic datasets:

```text
nListBuilder()
nSeparatedBuilder()
nGridBuilder()
NResponsiveGrid.builder()
NSliverColumn.builder()
NSliverGrid.builder()
NSliverResponsiveGrid.builder()
```

Builder implementations must preserve lazy construction and must not materialize all widgets into a list first.

## 8. Compatibility rule

Do not remove an existing public API solely to make the package cleaner. Prefer a non-breaking migration:

1. keep the old API available;
2. make the extension-first API the documented default;
3. stop using compatibility wrappers internally where possible;
4. only remove deprecated APIs in an intentional breaking release.

## 9. Return types

Public helpers should return `Widget` unless exposing a more specific Flutter type materially improves composition. Runtime output should still remain inspectable as ordinary Flutter widgets in Flutter Inspector and DevTools.
