# Components

## Convention

All components are **pure functions** returning Dash elements. No classes. One function per file in `components/<component_name>/<component_name>.py`.

## PageHeader

```python
from pure_webapp.components.page_header.page_header import PageHeader

PageHeader(
    icon="lucide:chart-bar",        # optional lucide icon
    title="My Feature",
    subtitle="Brief description",   # optional
)
```

Variants (auto-selected by args):
- `icon + subtitle` → full header
- `title only` → compact header (`page__header--compact`)

## Section (collapsible)

```python
from pure_webapp.components.section.section import Section

Section(
    title="Section Title",
    description="Optional description",    # optional
    extra_element=html.Div([...]),          # optional, rendered in aside
    content=html.Div([...]),
    open=True,                              # expanded by default
    id="feature__section-name",
)
```

## StandardCard

```python
from pure_webapp.components.standard_card.standard_card import StandardCard

StandardCard(
    id="my-card",
    title="Card Title",
    description="Optional description",
    action=Button("Export", icon="lucide:download"),  # optional
    content=html.Div([...]),
)
```

## Button

```python
from pure_webapp.components.button.button import Button

Button("Label", icon="lucide:plus", variant="primary", size="m", id="my-btn")
Button("Delete", variant="outline", destructive=True, id="delete-btn")
Button(icon="lucide:loader-2", loading=True, id="save-btn")
```

**Variants:** `"primary"`, `"ghost"`, `"outline"`, `"ghost secondary"`
**Sizes:** `"2xs"`, `"xs"`, `"s"`, `"m"`

## MultiSelect (with Select All)

```python
from pure_webapp.components.multiselect.multiselect import MultiSelect, with_select_all_option

options = [{"label": "Item A", "value": "a"}, {"label": "Item B", "value": "b"}]

MultiSelect(
    element_id={"type": "my-page__filter", "id": "my-filter"},
    options=with_select_all_option(options),
    placeholder="Selecionar...",
    width="260px",
    manage_value=True,   # handles __all__ sentinel automatically
)
```

The component auto-registers its own callbacks. Use `manage_value=False` if managing value externally.

## Table (AG Grid)

```python
from pure_webapp.components.table.V1.table import Table

Table(
    data_frames=[{"df": my_dataframe, "col_def": [...]}],
    grid_id="my-feature-grid",
    title="My Table",
    height={"mode": "rows", "value": 12},
    overflow="scroll",    # "scroll" | "paginate" | "clip"
    expandable=False,
    primary_action=("Add Row", my_add_row_callback),
)
```

**Height modes:**
- `{"mode": "auto"}` — grows to content
- `{"mode": "px", "value": 480}` — fixed pixels
- `{"mode": "rows", "value": 12}` — ~N visible rows
- `{"mode": "vh", "value": 60}` — 60% viewport height
- `{"mode": "parent"}` — fill parent

## Tabs

```python
from pure_webapp.components.tabs.tabs import Tabs
from dash.dcc import Tab

Tabs(
    value="tab1",
    size="medium",   # "small" | "medium" | "large"
    children=[
        Tab(label="Tab One", value="tab1", children=section1),
        Tab(label="Tab Two", value="tab2", children=section2),
    ],
)
```

## Writing a New Component

```python
# components/my_component/my_component.py
from typing import Any, Optional
from dash import html

def MyComponent(
    title: str,
    content: Any = None,
    id: str = "my-component",
    className: Optional[str] = None,
) -> html.Div:
    classes = ["my-component"]
    if className:
        classes.append(className)
    return html.Div(
        [
            html.Header(title, className="my-component__title"),
            html.Div(content, className="my-component__content", id=f"{id}__content"),
        ],
        id=id,
        className=" ".join(classes),
    )
```

**Rules:**
- Use `**kwargs` sparingly — only for well-known Dash props (e.g., `style`, `className`)
- Auto-register callbacks inside the component file when the component needs its own interactivity
- Guard with a module-level `set` to prevent duplicate callback registration
