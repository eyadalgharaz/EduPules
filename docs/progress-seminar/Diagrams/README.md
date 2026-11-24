# EduPules — Diagrams

All diagrams use the EduPules name and the four official roles (Admin, Professor, Teaching Assistant, Student).

| Diagram | Editable source | Exports | Slide |
|---|---|---|---|
| Concept pipeline (6 stages) | native shapes in the deck · `concept_pipeline.mmd` | `concept_pipeline_slide.png` | 7 |
| UML use case (4 actors + Gemini) | `use_case.dot` (Graphviz, fixed layout; needs `actor.png`): `neato -Tsvg use_case.dot -o use_case.svg` | `use_case.png`, `use_case.svg`, `use_case_slide.png` | 10 |
| Activity: early warning → intervention | native shapes in the deck · `activity_early_warning_to_intervention.mmd` | `activity_early_warning_to_intervention_slide.png` | 11 |
| Layered architecture | native shapes in the deck · `system_architecture.mmd` | `system_architecture_slide.png` | 12 |
| ER diagram (core tables) | native shapes in the deck · `er_diagram.dot` (Graphviz alternative layout): `dot -Tsvg er_diagram.dot -o er_diagram.svg` | `er_diagram_slide.png`, `er_diagram.png`, `er_diagram.svg` | 13 |
| Gantt baseline plan | native shapes in the deck · `gantt_baseline_plan.mmd` | `gantt_baseline_plan_slide.png` | 16 |

`.mmd` files render at https://mermaid.live or with `mmdc -i file.mmd -o file.svg`.
