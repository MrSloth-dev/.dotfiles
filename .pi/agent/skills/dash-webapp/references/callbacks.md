# Callbacks

## Central Registration

All callbacks are wired in `callbacks/__init__.py` via a `register_callbacks(app)` function called once in `main.py`.

```python
# callbacks/__init__.py
from dash import callback, Output, Input, State
from .my_feature import register_my_feature_callbacks

def register_callbacks(app):
    register_my_feature_callbacks()
    # ... other modules

    @callback(
        Output("app__sidebar", "className"),
        Input("toggle-btn", "n_clicks"),
        State("sidebar--state", "data"),
    )
    def update_sidebar(n_clicks, state):
        ...

__all__ = ["register_callbacks"]
```

## Page-Specific Callback File

```python
# callbacks/my_feature.py
from dash import callback, Output, Input, State
import requests
from pure_webapp.config import settings

BACKEND_URL = settings.backend.url

def register_my_feature_callbacks():
    @callback(
        Output("my-feature__last-update", "children"),
        Input("url-my-feature", "pathname"),
    )
    def update_last_update(_url):
        try:
            response = requests.get(f"{BACKEND_URL}/my-feature/last_update")
            response.raise_for_status()
            return response.json().get("last_update", "Indisponível")
        except requests.RequestException:
            return "Última atualização indisponível"
```

## Async Concurrent Fetching

Use `httpx` + `asyncio.gather` for multiple parallel API calls:

```python
import asyncio
import httpx

async def fetch_page_data(start_date, end_date):
    base = f"{BACKEND_URL}/my-feature"
    async with httpx.AsyncClient() as client:
        task_a = client.get(f"{base}/data-a", params={"start_date": start_date, "end_date": end_date})
        task_b = client.get(f"{base}/data-b", params={"start_date": start_date, "end_date": end_date})
        res_a, res_b = await asyncio.gather(task_a, task_b)

    return {
        "data_a": res_a.json() if res_a.status_code == 200 else [],
        "data_b": res_b.json() if res_b.status_code == 200 else [],
    }
```

## Filter Callbacks (Pattern-Matching with ALL)

```python
from dash import ALL, Input, Output, State, callback

_REGISTERED: set[str] = set()

def register_store_filters_callback(*, page_name: str):
    if page_name in _REGISTERED:
        return

    @callback(
        Output(f"{page_name}-active-filters", "data"),
        Input({"type": f"{page_name}__filter", "id": ALL}, "value"),
        State({"type": f"{page_name}__filter", "id": ALL}, "id"),
    )
    def store_active_filters(values, ids):
        filters = {}
        for value, comp_id in zip(values, ids):
            filters[comp_id["id"]] = value
        return filters

    _REGISTERED.add(page_name)
```

Prevent duplicate callback registration with a module-level `set`.

## Collapsible Table Callbacks

```python
def register_collapsible_callback(*, grid_id: str, open_store_id: str, tree_store_id: str):
    @callback(
        Output(grid_id, "rowData", allow_duplicate=True),
        Output(open_store_id, "data"),
        Input(grid_id, "cellClicked"),
        State(grid_id, "rowData"),
        State(open_store_id, "data"),
        State(tree_store_id, "data"),
        prevent_initial_call=True,
    )
    def on_cell_clicked(cell_clicked, current_rows, open_parents, tree_data):
        ...
```

## Table Add-Row Callback

```python
import uuid
import pandas as pd
from dash import callback, Input, Output, State

def register_add_row_callback(grid_id: str, df: pd.DataFrame):
    @callback(
        Output(grid_id, "rowData", allow_duplicate=True),
        Input(f"{grid_id}-primary-btn", "n_clicks"),
        State(grid_id, "rowData"),
        prevent_initial_call=True,
    )
    def add_new_row(n_clicks, current_data):
        if not n_clicks:
            return current_data or df.to_dict("records")
        current_data = current_data or df.to_dict("records")
        new_row = {k: (0 if isinstance(v, (int, float)) else "-") for k, v in (current_data[0] if current_data else {}).items()}
        new_row["id"] = str(uuid.uuid4())
        return [new_row] + current_data
```

## Rules

- Always use `prevent_initial_call=True` on callbacks that should not fire on page load.
- Use `allow_duplicate=True` on `Output` when multiple callbacks write to the same property.
- Return `no_update` (`from dash import no_update`) when nothing should change.
- Avoid logic in the callback decorator itself — delegate to helper functions.
