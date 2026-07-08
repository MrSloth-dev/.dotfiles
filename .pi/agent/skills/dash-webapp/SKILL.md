---
name: dash-webapp
description: "Apply consistent coding standards for Dash Python web applications. Use when creating new pages, registering pages, writing callbacks, building components, or structuring a Dash app. Based on the Pure webapp reference architecture. Covers: (1) page registration with dash.register_page, (2) callback organization and registration patterns, (3) function-based component conventions, (4) layout with Container/Row/Col grid system, (5) configuration with Pydantic BaseSettings, (6) naming conventions for IDs, CSS classes, and functions."
---

# Dash Webapp Standards

Reference architecture: `src/pure_webapp/`

## Project Structure

```
<app>/
├── main.py                  # App init, layout, auth, register_callbacks(app)
├── config.py                # Pydantic BaseSettings
├── pages/                   # Auto-registered via use_pages=True
│   └── <feature>/
│       └── <page>.py        # dash.register_page + layout + build_*_section()
├── components/              # Pure functions returning Dash elements
│   └── <component>/
│       └── <component>.py
├── callbacks/               # Event handlers
│   ├── __init__.py          # register_callbacks(app) — central entry point
│   └── <feature>.py
├── utils/
│   ├── base/grid_system/    # Container, Row, Col
│   └── funcoes_utils.py     # Shared utilities
└── assets/                  # CSS, images, JS
```

## Quick Reference

| Task | Reference |
|---|---|
| Add a new page | See [pages.md](references/pages.md) |
| Write callbacks | See [callbacks.md](references/callbacks.md) |
| Build a component | See [components.md](references/components.md) |
| Naming (IDs, CSS, functions) | See [conventions.md](references/conventions.md) |

## App Initialization (`main.py`)

```python
from dash import Dash, page_container, dcc, html
from flask import Flask
import dash_mantine_components as dmc
from pure_webapp.callbacks import register_callbacks
from pure_webapp.config import settings

server = Flask(__name__)
app = Dash(
    __name__,
    use_pages=True,                     # auto-discovers pages/
    server=server,
    external_stylesheets=[...],
    title="App Title",
)
app.server.secret_key = settings.app.secret

app.layout = dmc.MantineProvider(
    html.Div([
        dcc.Store(id="sidebar--state", data={"open": True}),
        html.Aside(id="app__sidebar", className="app__sidebar", children=[...]),
        html.Div(className="app__main-content", children=[
            dcc.Location(id="url", refresh="callback-nav"),
            page_container,
        ]),
    ], className="app")
)

register_callbacks(app)
```

## Configuration (`config.py`)

```python
from pydantic_settings import BaseSettings, SettingsConfigDict

class ApplicationSettings(BaseSettings):
    model_config = SettingsConfigDict(env_prefix="APP_")
    host: str
    secret: str

class AllSettings(BaseSettings):
    app: ApplicationSettings = ApplicationSettings()
    # add backend, auth, etc.

settings = AllSettings()
```

Usage: `from <app>.config import settings` → `settings.app.host`
