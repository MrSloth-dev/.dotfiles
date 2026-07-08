# SOLID — Pragmatic Guide

Rule: only flag a violation if it causes **actual pain** — bugs, brittle tests, or change cascades.
Skip violations that are purely theoretical or require imagining future requirements.

---

## S — Single Responsibility

**Real violation:** One class/function does two unrelated things that change for different reasons,
and you've already seen or can clearly predict that they will diverge.

Example (flag): `UserService` handles auth logic AND sends marketing emails. Auth changes
when security requirements change; emails change when marketing changes. Already causing
merge conflicts or unrelated test breakage.

**Skip:** A function that does two related things cleanly. "Responsibility" is not "one method".
Don't split a 30-line function into two 15-line functions just to claim SRP compliance.

---

## O — Open/Closed

**Real violation:** Adding a new case requires modifying an existing `if/elif` chain in a hot path,
and new cases are added frequently (you can see the git history).

Example (flag): A `calculate_fee` function with 6 `if payment_method == X` branches, new
payment methods added every quarter.

**Skip:** A switch/if-else that has been stable for 2 years. Premature extension points are
over-engineering. Don't add a strategy pattern "just in case".

---

## L — Liskov Substitution

**Real violation:** A subclass overrides a method and throws `NotImplementedError`, returns
a different type, or silently ignores required behavior. Callers break when receiving the subclass.

Example (flag): `ReadOnlyRepository` extends `Repository` but raises on `save()`. Code that
receives a `Repository` will crash with a `ReadOnlyRepository`.

**Skip:** Minor behavioral differences in subclasses that don't affect callers. Not every override
is an LSP violation.

---

## I — Interface Segregation

**Real violation:** A class must implement 5 methods from an interface but only 2 are ever called
on it, and the other 3 are implemented as stubs/`pass`/`raise NotImplementedError`.

Example (flag): `IDataSource` has `read`, `write`, `delete`, `bulk_import`, `export_csv`.
A read-only adapter implements all five but only `read` is used; the rest raise.

**Skip:** Small interfaces with a few extra methods. Don't split every interface into micro-traits.
Python protocols and duck typing already reduce this problem significantly.

---

## D — Dependency Inversion

**Real violation:** High-level business logic directly instantiates low-level infrastructure
(DB clients, HTTP clients, file handles), making unit testing impossible without patching internals.

Example (flag): `OrderService.__init__` calls `psycopg2.connect(...)` directly. Can't test
`OrderService` without a real database.

**Skip:** Simple scripts, CLI tools, or glue code where testability isn't a goal. Don't demand
DI for everything — only where the coupling actually hurts.

---

## Summary table

| Principle | Flag when... | Skip when... |
|-----------|-------------|--------------|
| SRP | Two unrelated change axes already causing pain | Just "more than one method" |
| OCP | Frequently modified if/elif chains | Stable code with no history of growth |
| LSP | Subclass breaks callers | Minor behavioral difference, no breakage |
| ISP | Stub/raise implementations for unused methods | Few extra methods, nothing broken |
| DIP | Infrastructure instantiated in business logic, blocking tests | Scripts, glue code, low-value test targets |
