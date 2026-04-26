# Project Global Engineering Rules

## 1) Clean code always
- Keep code clean, readable, and maintainable.
- Prefer clarity over cleverness.

## 2) Small files and functions
- Files and functions must stay small and focused.
- Avoid large classes or overly complex files.

## 3) Comments only when necessary
- Add comments only when the intent is not obvious.
- Do not add redundant or obvious comments.

## 4) MVVM Architecture discipline (strict)

- Follow MVVM layer boundaries strictly
  presentation → data
- Each layer must have a single responsibility.
- Never bypass layers or mix responsibilities.
- Do not put business logic inside the UI (views).
- UI must only handle rendering, user interaction, and state observation.
- Views must only listen to Cubit (ViewModel) and rebuild UI accordingly.
- All presentation logic and state management must reside in Cubits (ViewModel).
- Data layer must only handle API calls, persistence, and data mapping (models + repositories).
- UI must never call repositories directly; all actions must go through Cubits.
- Cubits must never call APIs directly; they must use repositories.
- Follow this folder structure:
  data/
    models/
    repositories/

  presentation/
    cubits/
     views/
      widgets/

- Models must be pure data classes (fromJson / toJson only).
- Repositories handle API calls and data sources only.
- Views must be UI only (no logic).
- Widgets must be reusable UI components only.
- Keep code clean, readable, and maintainable.
- Do not introduce unnecessary abstractions or overengineering.


## 5) Apply SOLID, DRY, and sound engineering principles
- Apply SOLID, DRY, and other sound engineering principles when beneficial.
- Do not force patterns unnecessarily.

## 6) Root-cause first
- Always identify and fix the root cause, not just symptoms.
- Do not apply superficial fixes.

## 7) Minimal safe changes
- Make the smallest possible change that solves the problem.
- Do not refactor unrelated code unless explicitly requested.

## 8) No breaking changes
- Do not break existing functionality, APIs, flows, or UX unless explicitly instructed.

## 9) Follow repository conventions
- Follow existing architecture, folder structure, naming conventions, and patterns.
- Do not introduce a new style inconsistent with the project.

## 10) Core folder for shared components
- Any reusable logic, utilities, services, constants, extensions, helpers, or shared components used in more than one place must be placed in the core folder.
- Avoid duplication across features.

## 11) Performance awareness (Flutter)
- Follow Flutter performance best practices at all times.
- Avoid unnecessary widget rebuilds.
- Prefer const constructors wherever possible.
- Avoid heavy work inside build methods.
- Be careful when using setState
  - Use setState only for local UI state when necessary.
  - Never use setState for business logic or feature state.
  - Prefer CubitBloc for managing feature and application state.
  - Avoid triggering unnecessary rebuilds of large widget trees.
- Prefer efficient widget composition and separation to minimize rebuild scope.
- Avoid unnecessary object allocations inside build methods.
- Avoid creating controllers (`TextEditingController`, `AnimationController`), `FocusNode`, or other expensive objects inside `build()`.
- Dispose controllers and focus nodes properly when owned by widgets (use `dispose()` in `StatefulWidget`).

## 12) State management discipline (Cubit)
- Use CubitBloc for feature state and business logic coordination.
- UI must never contain business logic.
- UI must only observe state and trigger Cubit actions.
- Do not bypass architecture layers.

## 13) Edge cases and error handling
- Properly handle null, empty, loading, and error states.
- Do not allow silent failures.
- Always ensure safe and predictable behavior.
- Use a consistent error handling strategy across layers
  - Data layer: catch exceptions and map them to typed Failure/Error models.
  - ViewModel (Cubit): handle failures and emit appropriate states (Loading, Success, Error).
  - Presentation layer (Views): map states to user-friendly messages and proper UI (loading indicators, error messages, empty states).
- Errors must propagate cleanly data → ViewModel → presentation, never skip layers.


## 14) Dependencies rule
- Do not add new packages unless necessary and justified.
- Any package added must be
  - Latest stable version
  - Well-maintained
  - Production-grade and trusted

## 15) Security awareness
- Always consider security implications.
- Proactively warn about potential security risks.
- Never hardcode secrets, tokens, or credentials.
- Do not log sensitive information.
- Safely validate and handle external and API data.

## 16) Follow modern best practices
- Always follow current (2026) best practices and modern FlutterDart standards.
- Prefer native Dart 3+ features over code generation libraries
  - Use `sealed class` for state unions and exhaustive pattern matching.
  - Avoid Freezed or other code generation unless the project explicitly adopts it.
  - Keep the project free from unnecessary build_runner dependencies.

## 17) Team mindset (engineering partner mode)
- Act as a senior engineer partner, not just a task executor.
- Suggest improvements when valuable.
- Think critically about solutions.
- Explain tradeoffs briefly when relevant.

## 18) No assumptions without verification
- Always read and understand relevant code before modifying it.
- Do not assume behavior without verification.
- Ask or clearly state assumptions if something is unclear.

## 19) Avoid duplication
- Reuse existing logic when available.
- Do not duplicate code unnecessarily.

## 20) Dart naming conventions and best practices
- Follow official Dart style guide and conventions
  - Files `snake_case.dart`
  - Classes, enums, typedefs `PascalCase`
  - Variables, functions, parameters `camelCase`
  - Constants `camelCase` (not SCREAMING_CAPS)
  - Private members prefix with `_`
- Feature folder structure `feature_namedata`, `feature_namedomain`, `feature_namepresentation`
- Follow Effective Dart guidelines for API design, usage, and documentation.

## 21) Import ordering
- Organize imports in this order, separated by blank lines
  1. Dart SDK imports (`dart`)
  2. Flutter SDK imports (`packageflutter`)
  3. Third-party package imports (`package`)
  4. Project package imports (`packageproject_name`)
- Use relative imports within the same feature.
- Use package imports across features.
- Never use unused imports.

## 22) Separation of concerns enforcement
- Presentation layer must not directly access repositories or data sources.
- All operations must go through Cubits (ViewModel).
- Views must depend only on Cubits, never directly on repositories or data sources.
- Cubits must depend on repositories to retrieve and manage data.
- Data layer must remain independent of UI and Flutter-specific code.


## 23) Completion self-review checklist (mandatory)
Before finishing any task, verify
- The root cause is correctly addressed.
- The solution is safe and minimal.
- No existing functionality is broken.
- Architecture rules are respected.
- No business logic exists in UI.
- No performance regressions introduced.
- No security risks introduced.

Then provide a brief summary of
- What was changed
- Why it was changed
- Why the solution is safe and correct

## 24)UI Refactor (VERY IMPORTANT):
- Break ALL large screens into small reusable widgets
- Move widgets into:
  presentation/views/widgets/
IMPORTANT CLARIFICATION:
- These widgets are FEATURE-SPECIFIC widgets, NOT global/shared widgets.
- Each feature must have its OWN widgets folder:
  Example:
    features/orders/presentation/widgets/
    features/home/presentation/widgets/
- Widgets inside this folder are ONLY used within that feature.
