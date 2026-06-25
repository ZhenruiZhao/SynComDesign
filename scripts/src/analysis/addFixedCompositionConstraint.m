function model = addFixedCompositionConstraint(model, ratios)
%ADDFIXEDCOMPOSITIONCONSTRAINT Constrain biomass fluxes to fixed ratios.
%
%   model = addFixedCompositionConstraint(model, ratios) adds linear equality
%   constraints so biomass_i / biomass_1 equals ratios_i / ratios_1. Ratios
%   must be positive and match the number of biomass reactions.

biomassRxns = cellstr(model.syncomdesign.biomassMap.biomass_rxn);
biomassRxns = biomassRxns(~cellfun(@isempty, biomassRxns));
n = numel(biomassRxns);
if nargin < 2 || isempty(ratios)
    ratios = ones(1, n);
end
ratios = ratios(:)';
if numel(ratios) ~= n
    error('addFixedCompositionConstraint:RatioLengthMismatch', ...
        'Expected %d composition ratios, got %d.', n, numel(ratios));
end
if any(ratios <= 0)
    error('addFixedCompositionConstraint:InvalidRatios', 'Composition ratios must be positive.');
end
ratios = ratios ./ sum(ratios);
rxnIdx = zeros(1, n);
for i = 1:n
    rxnIdx(i) = find(strcmp(model.rxns, biomassRxns{i}), 1);
end
for i = 2:n
    model.S(end+1, :) = sparse(1, numel(model.rxns));
    model.S(end, rxnIdx(i)) = ratios(1);
    model.S(end, rxnIdx(1)) = -ratios(i);
    model.mets{end+1, 1} = sprintf('syncomdesign_composition_constraint_%d', i - 1);
end
model.syncomdesign.compositionRatios = ratios;
model = syncCobraConstraintFields(model);
end
