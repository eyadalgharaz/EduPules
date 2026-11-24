# EduPules — Diagram sources

| Diagram | Editable source | Image | Deck slide |
|---|---|---|---|
| General use case | `EduPules_Diagrams_Editable.pptx` slide 1 (native shapes) · `use_case.puml` | `use_case.png` | 9 |
| Sequence (alert → warning) + class (risk engine) | slide 2 · `sequence_alert.puml`, `class_risk_engine.puml` | `sequence_and_class.png` | — (not in the deck) |
| System architecture | slide 3 · `architecture.mmd` | `architecture.png` | 10 |
| ERD (core entities) | `erd.dot` (Graphviz) | `erd.png`, `erd.svg`, `erd_slide.png` | 11 |

Render: PlantUML (`plantuml file.puml` or plantuml.com), Mermaid (mermaid.live / `mmdc`), Graphviz (`dot -Tsvg erd.dot -o erd.svg`).
The Advisor role's profile is stored in the `teaching_assistants` table (see the technical report). Diagrams show the logical name "Advisor".
