---
name: flutter-run
description: Launch this Flutter app in Chrome and drive it with claude-in-chrome to verify a UI change actually works. Use whenever asked to run, start, preview, or screenshot the app, or to confirm a change works in the real app rather than just via flutter analyze/flutter test.
---

# Running this app

This is a Flutter app (no backend, no golden-file/integration test harness). The
fastest way to see a change working is the web target in Chrome — no simulator
boot time, and it's driveable with the claude-in-chrome tools.

## Launch

```bash
lsof -ti:8765 | xargs kill -9 2>/dev/null   # free the port if a previous run is still up
nohup flutter run -d chrome --web-port=8765 > /tmp/flutter_run.log 2>&1 &
```

Wait for readiness before navigating:

```bash
until grep -qE "is available at|Lost connection|Error" /tmp/flutter_run.log 2>/dev/null; do sleep 2; done
```

Then use the claude-in-chrome tools: `tabs_context_mcp` (createIfEmpty: true) →
`navigate` to `http://localhost:8765` → wait ~3s for the Flutter web engine to
boot → screenshot.

## Known gotchas

- **A running `flutter run` session does not reliably hot-reload edits made
  after it started**, especially when launched detached/backgrounded (no
  attached stdin for the `r`/`R` hot-reload/restart keys). If a screenshot
  doesn't reflect a source change you just made, don't trust it — kill the
  process (`pkill -9 -f "flutter run -d chrome"`) and relaunch fresh before
  concluding the change didn't work.
- **Mouse-wheel scroll via the `computer` tool's `scroll` action often doesn't
  move Flutter web's canvas-rendered content.** If a screenshot looks stuck
  after scrolling, dispatch a real `WheelEvent` at the target point instead:

  ```js
  const el = document.elementFromPoint(x, y);
  el.dispatchEvent(new WheelEvent('wheel', {deltaY: 2000, clientX:x, clientY:y, bubbles:true}));
  ```

  via `javascript_tool`.
- The app defaults to dark mode (`ThemeController._mode = ThemeMode.dark`).
  To check light mode, navigate to Services → scroll to the "APPEARANCE"
  section → click "Light". See the `theme-audit` skill for a full pass across
  screens and themes — this app has had recurring light/dark contrast bugs
  (see the "Theming" section of `CLAUDE.md`).
- Always kill the `flutter run` process when done (`pkill -9 -f "flutter run -d chrome"`)
  so the port is free for the next run.
