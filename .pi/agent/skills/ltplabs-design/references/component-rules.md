# Component Rules

- Button: keep sizes to `xs`, `sm`, and `md`; keep variants to `Primary`, `Outline`, and `Ghost`; use `destructive=True` for destructive actions; use `loading=True` for slow actions.
- Select: treat it as a styled wrapper around `dcc.Dropdown`; keep labels, placeholder text, helper messages, and error state aligned with the README.
- Section: use it for grouped collapsible content; keep `title`, `description`, `extra_element`, `content`, and `open` aligned with the documented behavior.
- Breadcrumb: treat it as URL-driven and auto-rendered in the app layout; do not recreate it manually in pages unless the docs say otherwise.
- Menu: use it for sidebar navigation; keep simple links and expandable children consistent with the app layout.
- Tabs and Segmented Control: follow the documented `Tab`-child pattern and icon class conventions.
- TableV1: keep `grid_id` unique and align `data_frames`, `tab`, `height`, and overflow settings with the README.
- Indicator Card: keep the row tuple structure and optional badge behavior exactly as documented.
