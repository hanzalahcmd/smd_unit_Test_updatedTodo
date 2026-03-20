# ✅ My Tasks — Flutter (with Logic & Tests)

A Flutter todo app with local persistence, extracted business logic, and unit tests.

---


## Features

- View tasks as a scrollable card list
- Check/uncheck tasks with a checkbox (strikethrough on completion)
- Add new tasks via a dialog prompt
- **Sort tasks** — pending tasks float to the top, completed sink to the bottom
- **Mark all done** — single tap to complete every task at once
- Tasks persist across app restarts using `shared_preferences` + JSON encoding
- Default tasks loaded on first launch
- Business logic separated into `todo_logic.dart` for testability

---

## Getting Started

### Prerequisites

- Flutter SDK `>=3.0.0`
- Dart `>=3.0.0`

### Installation

```bash
git clone https://github.com/your-username/smd_persistent_todo_app.git
cd smd_persistent_todo_app
flutter pub get
flutter run
```

### Running Tests

```bash
flutter test
```

---

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter
```

---

## Project Structure

```
lib/
├── main.dart           # UI, state management, load/save logic
└── todo_logic.dart     # Pure business logic functions

test/
└── todo_logic_test.dart  # Unit tests for markAllDone & sortTasks
```

---

## Business Logic (`todo_logic.dart`)

| Function | Description |
|----------|-------------|
| `markAllDone(tasks)` | Returns a new list with every task marked `isDone: true` |
| `sortTasks(tasks)` | Returns a new list with pending tasks first, completed last |

Both functions are **pure** — they do not mutate the original list.

---

## Unit Tests

| Test | What it checks |
|------|---------------|
| `markAllDone marks every task as done` | All tasks have `isDone == true` after call |
| `sortTasks puts incomplete tasks before completed` | Ordering is pending → completed |
| `markAllDone does not modify the original list` | Original list is unchanged (immutability) |

---

## Authors

22k-4156 · 22k-4574 · 22k-4431 · 22k-4494

---

## License

MIT License.
