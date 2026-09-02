# Grid builder APIs

Use `nGrid()` when you already have a small or prebuilt collection of widgets.
Use `nGridBuilder()` when items should be built lazily from an indexed data source.

## Prebuilt widgets

```dart
<Widget>[
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

`nGrid()` directly returns Flutter's `GridView.count`.

## Lazy builder

```dart
nGridBuilder(
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
);
```

`nGridBuilder()` directly returns Flutter's `GridView.builder` and keeps item construction lazy.

## Choosing an API

```text
Already-built widgets
→ nGrid()
→ GridView.count

Indexed or large dataset
→ nGridBuilder()
→ GridView.builder
```

No additional Nestless runtime widget is inserted by either API.
