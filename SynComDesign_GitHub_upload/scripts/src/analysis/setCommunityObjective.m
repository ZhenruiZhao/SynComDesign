function model = setCommunityObjective(model, objectiveConfig)
%SETCOMMUNITYOBJECTIVE Configure biomass or target objective on a model.
if nargin < 2 || isempty(objectiveConfig)
    objectiveConfig = struct('type', 'total_biomass');
end
model.c(:) = 0;
biomassRxns = {};
if isfield(model, 'syncomdesign') && isfield(model.syncomdesign, 'biomassMap')
    biomassRxns = cellstr(model.syncomdesign.biomassMap.biomass_rxn);
    biomassRxns = biomassRxns(~cellfun(@isempty, biomassRxns));
end
switch lower(string(objectiveConfig.type))
    case {"total_biomass","growth_then_n2o_consumption","weighted_biomass_function","fixed_composition","equal_composition"}
        idx = findRxnIdsSafe(model, biomassRxns);
        model.c(idx) = 1;
    case "target_strain_biomass"
        if ~isfield(objectiveConfig, 'target_strain') || isempty(objectiveConfig.target_strain)
            error('setCommunityObjective:MissingTargetStrain', 'target_strain_biomass requires target_strain.');
        end
        target = string(objectiveConfig.target_strain);
        rows = strcmpi(string(model.syncomdesign.biomassMap.strain), target);
        if ~any(rows)
            error('setCommunityObjective:TargetStrainNotInCommunity', ...
                'Target strain "%s" is not present in this community.', char(target));
        end
        idx = findRxnIdsSafe(model, cellstr(model.syncomdesign.biomassMap.biomass_rxn(rows)));
        model.c(idx) = 1;
    otherwise
        error('setCommunityObjective:UnknownObjective', 'Unknown objective type: %s', objectiveConfig.type);
end
end

function idx = findRxnIdsSafe(model, rxns)
idx = [];
for i = 1:numel(rxns)
    hit = find(strcmp(model.rxns, rxns{i}), 1);
    if isempty(hit)
        error('setCommunityObjective:MissingReaction', 'Objective reaction not found: %s', rxns{i});
    end
    idx(end+1) = hit; %#ok<AGROW>
end
end
