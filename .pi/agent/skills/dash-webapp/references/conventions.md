# Conventions

## File & Directory Naming

| Location | Convention | Example |
|---|---|---|
| `pages/` | `snake_case/snake_case.py` | `entradas_leite/entradas_leite.py` |
| `components/` | `snake_case/snake_case.py` | `standard_card/standard_card.py` |
| `callbacks/` | `snake_case.py` | `estado_atual.py` |
| `utils/` | `snake_case.py` | `funcoes_utils.py` |
| URL paths | `kebab-case` | `/entradas-de-leite` |

## Component/Element ID Naming

**Separators:**
- `__` (double underscore) — parent-child within a component: `app__sidebar`, `standard-card__content`
- `--` (double dash) — state or variant: `sidebar--state`, `button--loading`
- `-` (single dash) — word separator: `toggle-btn`, `last-update`

**Pattern:** `<page-or-feature>__<element>` or `<page>-<element>`

Examples:
```python
"app__sidebar"
"app__header-menuIcon"
"sidebar--state"                         # dcc.Store
"coverages-active-filters"               # dcc.Store for filters
"my-feature__visao-geral-section"        # Section id
{"type": "my-feature__filter", "id": "centro"}   # Pattern-matched component
```

## CSS Class Naming (BEM)

Pattern: `block__element--modifier`

```
page__header
page__header--compact
page__header-icon

sidebar__menu
sidebar__header-logo

button
button--primary
button--s
button--loading
button--destructive

standard-card__header
standard-card__content
standard-card__title

smart-multiselect__wrapper
smart-multiselect__summary-text
```

## Function Naming

| Category | Pattern | Examples |
|---|---|---|
| Section builders | `build_<name>_section()` | `build_visao_geral_section()` |
| Callback handlers | `update_<component>()` | `update_sidebar()`, `update_last_update()` |
| Data fetchers | `fetch_<name>_data()` | `fetch_timeseries_data()` |
| Filter appliers | `apply_<name>()` | `apply_filters()` |
| Data loaders | `load_<name>_data()` | `load_main_table_data()` |
| Callback registers | `register_<name>_callback()` | `register_store_filters_callback()` |
| Private/internal | `_<name>()` | `_normalize_payload()`, `_id_key()` |

## Variable Naming

| Category | Pattern | Examples |
|---|---|---|
| Store/Data | `<name>_data` | `filters_data`, `tree_data` |
| Config objects | `<name>_config` | `data_config`, `primary_data_config` |
| Configuration maps | `<DOMAIN>_CONFIG` (UPPER) | `FILTERS_CONFIG`, `BREAKPOINTS` |
| Click args | `<trigger>_clicks` | `toggle_clicks`, `menu_clicks` |
| Current state | `current_<name>` | `current_data`, `current_state` |
| Async tasks | `<name>_task` | `service_level_task`, `stock_task` |

## Sentinel Values

Use module-level `set` to guard against duplicate callback registration:

```python
_REGISTERED_CALLBACKS: set[str] = set()

def register_my_callback(*, page_name: str):
    if page_name in _REGISTERED_CALLBACKS:
        return
    # define @callback here
    _REGISTERED_CALLBACKS.add(page_name)
```

Use `"__all__"` as the sentinel value for "Select All" in multi-select filters.

## TypedDict for Complex Data

```python
from typing import Any, Dict, List, NotRequired, Optional, TypedDict

class MyConfig(TypedDict):
    df: Any
    col_def: NotRequired[List[Dict[str, Any]]]
    title: NotRequired[Optional[str]]
```

## Constants

Define at module level in UPPER_SNAKE_CASE:

```python
from datetime import date, timedelta

today = date.today()
START_OF_WEEK = today - timedelta(days=today.weekday())
END_OF_WEEK = START_OF_WEEK + timedelta(days=6)
BACKEND_URL = settings.backend.url
```
