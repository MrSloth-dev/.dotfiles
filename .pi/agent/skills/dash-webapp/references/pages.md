# Pages

## Registration

Every page file must call `dash.register_page` and expose a `layout` variable.

```python
import dash
from dash import html
from pure_webapp.components.page_header.page_header import PageHeader

dash.register_page(
    __name__,
    path="/my-feature",       # kebab-case URL
    title="My Feature",       # browser tab title
)

# Build sections separately for readability
visao_geral_section = build_visao_geral_section()
analise_section = build_analise_section()

layout = html.Div([
    html.Div(
        className="homepage__container",
        children=[
            PageHeader(
                icon="lucide:chart-bar",   # lucide icon name
                title="My Feature",
                subtitle="Description of what this page does.",
            ),
            # tabs or sections here
        ],
    ),
])
```

## File Location

```
pages/
└── my_feature/
    └── my_feature.py
```

Use **snake_case** for files and directories; **kebab-case** for URL paths.

## Tabs Pattern

```python
from pure_webapp.components.tabs.tabs import Tabs
from dash.dcc import Tab

MediumTabs = Tabs(
    value="visao_geral",
    size="medium",
    children=[
        Tab(label="Visão geral", value="visao_geral", children=visao_geral_section),
        Tab(label="Análise",     value="analise",     children=analise_section),
    ],
)
```

## Section Builder Functions

Break complex page content into `build_<section_name>_section()` functions:

```python
def build_visao_geral_section() -> html.Div:
    from pure_webapp.components.section.section import Section
    return Section(
        title="Visão Geral",
        description="Overview of current state.",
        id="my-feature__visao-geral-section",
        open=True,
        content=html.Div([...]),
    )
```

## Grid Layout

```python
from pure_webapp.utils.base.grid_system.grid import Container, Row, Col

content = Container(
    Row([
        Col([card1], xs=12, md=6, lg=4),
        Col([card2], xs=12, md=6, lg=4),
        Col([card3], xs=12, md=6, lg=4),
    ]),
    fluid=True,
)
```

## Adding to Sidebar Menu (`main.py`)

```python
from pure_webapp.components.menu.menu import Menu

Menu(title="My Feature", href="/my-feature", icon="lucide:chart-bar"),
```
