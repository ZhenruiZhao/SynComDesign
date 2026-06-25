# SynComDesign

**Constraint-Based Design and Functional Evaluation of Synthetic Microbial Communities**

SynComDesign is a constraint-based computational framework for constructing,
enumerating, simulating, and evaluating synthetic microbial communities from
genome-scale metabolic models.

It supports CarveMe-generated models and BiGG identifiers, exhaustive community
combination enumeration, shared-environment community model construction,
growth and functional optimization, flux variability analysis, and prediction
of nitrate, nitrite, nitric oxide, nitrous oxide, and dinitrogen exchange.

## Overview

SynComDesign runs a MATLAB/COBRA Toolbox workflow for single-strain and
multi-strain community metabolic simulation. The current implementation is
configured for CarveMe/BiGG-style COBRA models and denitrification-oriented
exchange-flux analysis.

## Main Features

- CarveMe-generated model support.
- BiGG identifier support.
- Enumeration of all non-empty strain combinations.
- Single-strain and community metabolic simulation.
- Shared extracellular environment construction.
- Biomass prediction.
- Nitrate consumption prediction.
- Nitrite exchange prediction.
- Nitric oxide exchange prediction.
- Nitrous oxide consumption and production prediction.
- Dinitrogen production prediction.
- FBA and optional FVA.
- Configurable medium conditions.
- Anaerobic or oxygen-limited simulation through medium configuration.

## Requirements

- MATLAB.
- COBRA Toolbox on the MATLAB path.
- COBRA-compatible LP solver, such as Gurobi, GLPK, CPLEX, MOSEK, or another
  solver supported by COBRA Toolbox.
- CarveMe-generated models or other COBRA models using compatible BiGG-style
  reaction and metabolite identifiers.

CarveMe and BiGG are external tools or naming resources. Their code is not
bundled into this project.

## Installation

Open MATLAB, move into the project directory, and add the folder to the MATLAB
path:

```matlab
cd('path\to\SynComDesign')
addpath(genpath(pwd))
```

Initialize COBRA Toolbox and select an LP solver before running full analyses:

```matlab
initCobraToolbox(false);
changeCobraSolver('gurobi', 'LP');
```

## Input Models

Place COBRA-compatible `.xml`, `.sbml`, `.mat`, or `.json` models in the model
directory configured in `config/syncomdesign_config.yml`. The GitHub upload
layout reads XML models from `models/` by default.

Biomass reaction IDs can be specified in `config/biomass_reactions.tsv` when
automatic detection is ambiguous.

## Configuration

The main configuration files are:

- `config/syncomdesign_config.yml`
- `media/medium.tsv`
- `config/metabolite_aliases.tsv`
- `config/biomass_reactions.tsv`

The configuration preserves the existing scenario-style objective selection.
For example, `scenario_id: 5` runs the growth-first N2O-consumption objective.

## Quick Start

Run the current workflow with:

```matlab
results = runSynComDesign('config/syncomdesign_config.yml');
```

For a step-by-step Chinese beginner manual, see:

- `docs/USER_MANUAL_CN.md`

## Output

Results are written to the configured output directory, usually `results/`.
The workflow writes stable TSV/CSV tables for community summaries,
single-strain results, validation diagnostics, reaction and metabolite mapping,
and failed combinations.

Scientific output columns such as total biomass, strain biomass, nitrate
uptake, nitrite exchange, nitric oxide exchange, N2O uptake/secretion/net flux,
N2 production, FVA ranges, feasibility, and solver status retain their current
meaning.

## Interpretation

Uptake and secretion columns use positive biological rates:

- uptake is reported as `max(0, -exchangeFlux)`.
- secretion is reported as `max(0, exchangeFlux)`.
- net flux keeps the COBRA exchange-reaction direction.

For example, a COBRA exchange flux of `-3` through an N2O exchange reaction is
reported as positive N2O uptake.

## Limitations

SynComDesign depends on the quality of the input genome-scale metabolic models,
medium configuration, biomass-reaction assignment, exchange-reaction detection,
and LP solver setup. It does not automatically gap-fill models unless that
behavior is explicitly added and configured elsewhere.

This name migration does not remove any provenance, citation, permission, or
license obligations associated with the code and scientific ideas used to build
the current project.

## Notice

SynComDesign was created by modifying and extending an existing implementation
of the SuperCC workflow.

The software has been adapted to support CarveMe-generated metabolic models,
BiGG identifiers, exhaustive microbial community combination enumeration,
shared-environment community models, growth and functional optimization, flux
variability analysis, and denitrification-related exchange predictions.

The original SuperCC publication and GitHub repository should be cited when
using this software.

## Citation

If you use SynComDesign, please cite the SynComDesign software repository and
the publication describing the original SuperCC framework that informed the
development of this project.

Original SuperCC publication:

Ruan, Z., Chen, K., Cao, W. et al. Engineering natural microbiomes toward
enhanced bioremediation by microbiome modeling. Nature Communications 15, 4694
(2024). https://doi.org/10.1038/s41467-024-49098-z

Original SuperCC repository:

https://github.com/ruanzhepu/superCC

The current citation information for SynComDesign will be added after the
software repository or software paper is formally released.

## Acknowledgements

SynComDesign was developed by extending and adapting ideas and code from the
SuperCC project for CarveMe-generated genome-scale metabolic models, BiGG
identifiers, exhaustive strain-combination enumeration, community metabolic
simulation, and denitrification-oriented flux prediction.

Users should also cite the original SuperCC publication and GitHub repository.

SynComDesign is an independently maintained adaptation and is not an official
release of the original SuperCC project.
