function model = addAllSpeciesActiveConstraint(model, minimumFlux)
%ADDALLSPECIESACTIVECONSTRAINT Set biomass lower bounds for active strains.
if nargin < 2 || isempty(minimumFlux)
    minimumFlux = 1e-6;
end
if ~isfield(model, 'syncomdesign') || ~isfield(model.syncomdesign, 'biomassMap')
    return
end
for i = 1:height(model.syncomdesign.biomassMap)
    rxn = char(model.syncomdesign.biomassMap.biomass_rxn(i));
    if isempty(rxn)
        continue
    end
    idx = find(strcmp(model.rxns, rxn), 1);
    if ~isempty(idx)
        model.lb(idx) = max(model.lb(idx), minimumFlux);
    end
end
end
