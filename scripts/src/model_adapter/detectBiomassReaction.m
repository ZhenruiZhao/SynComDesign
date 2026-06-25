function result = detectBiomassReaction(model, configuredBiomassRxn)
%DETECTBIOMASSREACTION Detect a model biomass reaction.
%
%   result.biomassRxn is empty when no unique, defensible biomass reaction can
%   be selected. Candidate reactions are returned for diagnostics.

if nargin < 2
    configuredBiomassRxn = '';
end
rxns = safeCellstr(model.rxns);
candidates = {};

if ~isempty(configuredBiomassRxn)
    idx = find(strcmp(rxns, configuredBiomassRxn), 1);
    if isempty(idx)
        error('detectBiomassReaction:ConfiguredMissing', ...
            'Configured biomass reaction not found: %s', configuredBiomassRxn);
    end
    result = struct('biomassRxn', configuredBiomassRxn, 'candidates', {{configuredBiomassRxn}}, ...
        'source', 'configured');
    return
end

if isfield(model, 'c') && numel(model.c) == numel(rxns)
    objectiveIdx = find(model.c ~= 0);
    if numel(objectiveIdx) == 1
        candidates{end+1} = rxns{objectiveIdx}; %#ok<AGROW>
    end
end

rxnNames = rxns;
if isfield(model, 'rxnNames') && numel(model.rxnNames) == numel(rxns)
    rxnNames = safeCellstr(model.rxnNames);
end
nameHits = false(numel(rxns), 1);
patterns = {'biomass','growth','BIOMASS','Growth'};
for p = 1:numel(patterns)
    nameHits = nameHits | contains(rxns, patterns{p}, 'IgnoreCase', true) ...
        | contains(rxnNames, patterns{p}, 'IgnoreCase', true);
end
candidates = unique([candidates, rxns(nameHits)'], 'stable');

positiveCandidates = {};
if exist('optimizeCbModel', 'file') == 2
    for i = 1:numel(candidates)
        testModel = model;
        testModel.c(:) = 0;
        rxnIdx = find(strcmp(rxns, candidates{i}), 1);
        testModel.c(rxnIdx) = 1;
        try
            sol = optimizeCbModel(testModel);
            if isfield(sol, 'stat') && sol.stat == 1 && isfield(sol, 'f') && sol.f > 1e-9
                positiveCandidates{end+1} = candidates{i}; %#ok<AGROW>
            end
        catch
        end
    end
end

if numel(positiveCandidates) == 1
    biomassRxn = positiveCandidates{1};
    source = 'fba_positive_candidate';
elseif numel(candidates) == 1
    biomassRxn = candidates{1};
    source = 'single_candidate';
else
    biomassRxn = '';
    source = 'ambiguous_or_missing';
end

result = struct('biomassRxn', biomassRxn, 'candidates', {candidates}, ...
    'positiveCandidates', {positiveCandidates}, 'source', source);
end

function values = safeCellstr(values)
if isstring(values)
    values(ismissing(values)) = "";
    values = cellstr(values);
elseif iscell(values)
    values = cellfun(@missingToEmptyChar, values, 'UniformOutput', false);
else
    values = cellstr(values);
end
values = reshape(values, [], 1);
end

function value = missingToEmptyChar(value)
if isstring(value)
    if ismissing(value)
        value = '';
    else
        value = char(value);
    end
elseif ismissing(value)
    value = '';
elseif ~ischar(value)
    value = char(string(value));
end
end
