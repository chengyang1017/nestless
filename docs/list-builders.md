# List builder APIs

Nestless keeps ordinary Flutter list concepts as ordinary Flutter widgets.
There is no `NList` runtime wrapper.

## Existing iterable data

When the data already exists as an iterable, use `nList()`:

```dart
final users = <User>[
  User(name: 'Alice'),
  User(name: 'Bob'),
  User(name: 'Charlie'),
];

return users.nList(
  padding: const EdgeInsets.all(16),
  item: (user) {
    return ListTile(
      leading: const CircleAvatar(),
      title: Text(user.name),
    );
  },
);
```

`nList()` converts the iterable to an indexed data list, then delegates item
widgets to Flutter's `ListView.builder`.

For separators:

```dart
return users.nSeparated(
  padding: const EdgeInsets.all(16),
  item: (user) {
    return ListTile(
      title: Text(user.name),
    );
  },
  separator: const Divider(height: 1),
);
```

## Builder data sources

When the caller only has `itemCount` and an indexed builder, use
`nListBuilder()` directly:

```dart
return nListBuilder(
  itemCount: messages.length,
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
);
```

This directly returns Flutter's `ListView.builder`, so item widgets are built
lazily for the current viewport.

For indexed separators:

```dart
return nSeparatedBuilder(
  itemCount: messages.length,
  padding: const EdgeInsets.all(16),
  itemBuilder: (context, index) {
    return MessageTile(
      message: messages[index],
    );
  },
  separatorBuilder: (context, index) {
    return const Divider(height: 1);
  },
);
```

## Empty state

Both builder helpers support an empty widget without requiring an outer
conditional:

```dart
return nListBuilder(
  itemCount: messages.length,
  empty: const Center(
    child: Text('No messages'),
  ),
  itemBuilder: (context, index) {
    return MessageTile(
      message: messages[index],
    );
  },
);
```

## Choosing an API

```text
Existing Iterable<T>
  -> iterable.nList()

Existing Iterable<T> + separators
  -> iterable.nSeparated()

itemCount + indexed item builder
  -> nListBuilder()

itemCount + indexed item/separator builders
  -> nSeparatedBuilder()
```

All four paths end in standard Flutter `ListView` widgets.
