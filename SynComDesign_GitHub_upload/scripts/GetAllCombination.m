function [combinations, info] = GetAllCombination(speciesToConsider, varargin)
%GETALLCOMBINATION Enumerate all non-empty strain combinations.
%
%   combinations = GetAllCombination(speciesToConsider) returns a cell array
%   where each cell contains one row vector of strain indices. Combinations are
%   ordered first by community size and then by ascending strain index.
%
%   [combinations, info] = GetAllCombination(..., Name, Value) supports:
%     minCommunitySize  - minimum combination size, default 1
%     maxCommunitySize  - maximum combination size, default numel(species)
%     requiredSpecies   - species that must be present, default []
%     excludedSpecies   - species that must be absent, default []
%     maxCombinations   - maximum allowed count, default Inf
%     outputFormat      - 'cell' (default) or 'matrix'
%
%   info.totalCombinations stores the exact number before enumeration. This
%   function deliberately uses nchoosek and avoids deprecated combination APIs.

p = inputParser;
p.addRequired('speciesToConsider', @(x) isnumeric(x) || iscellstr(x) || isstring(x));
p.addParameter('minCommunitySize', 1, @(x) isempty(x) || (isscalar(x) && x >= 0));
p.addParameter('maxCommunitySize', [], @(x) isempty(x) || (isscalar(x) && x >= 0));
p.addParameter('requiredSpecies', [], @(x) isnumeric(x) || iscellstr(x) || isstring(x));
p.addParameter('excludedSpecies', [], @(x) isnumeric(x) || iscellstr(x) || isstring(x));
p.addParameter('maxCombinations', Inf, @(x) isscalar(x) && x > 0);
p.addParameter('outputFormat', 'cell', @(x) ischar(x) || isstring(x));
p.parse(speciesToConsider, varargin{:});
opts = p.Results;

species = normalizeSpeciesVector(speciesToConsider);
requiredSpecies = normalizeSpeciesVector(opts.requiredSpecies);
excludedSpecies = normalizeSpeciesVector(opts.excludedSpecies);

if isempty(species)
    combinations = {};
    info = struct('totalCombinations', 0, 'minCommunitySize', 0, ...
        'maxCommunitySize', 0, 'speciesToConsider', species);
    return
end

if numel(unique(species)) ~= numel(species)
    error('GetAllCombination:DuplicateSpecies', 'speciesToConsider must not contain duplicates.');
end
if any(~ismember(requiredSpecies, species))
    error('GetAllCombination:RequiredMissing', 'requiredSpecies must be a subset of speciesToConsider.');
end
if any(~ismember(excludedSpecies, species))
    error('GetAllCombination:ExcludedMissing', 'excludedSpecies must be a subset of speciesToConsider.');
end
if any(ismember(requiredSpecies, excludedSpecies))
    error('GetAllCombination:RequiredExcludedOverlap', 'requiredSpecies and excludedSpecies cannot overlap.');
end

availableSpecies = species(~ismember(species, excludedSpecies));
minSize = max(1, opts.minCommunitySize);
if isempty(opts.maxCommunitySize)
    maxSize = numel(availableSpecies);
else
    maxSize = min(opts.maxCommunitySize, numel(availableSpecies));
end
minSize = max(minSize, numel(requiredSpecies));

total = countCombinations(availableSpecies, requiredSpecies, minSize, maxSize);
info = struct('totalCombinations', total, 'minCommunitySize', minSize, ...
    'maxCommunitySize', maxSize, 'speciesToConsider', species, ...
    'requiredSpecies', requiredSpecies, 'excludedSpecies', excludedSpecies);

if total > opts.maxCombinations
    error('GetAllCombination:TooManyCombinations', ...
        'Requested %d combinations, exceeding maxCombinations=%g.', total, opts.maxCombinations);
end
if total > 100000
    warning('GetAllCombination:LargeEnumeration', ...
        'Enumerating %d combinations. Consider limiting community size.', total);
end

combinations = cell(total, 1);
k = 1;
for sizeNow = minSize:maxSize
    raw = nchoosek(availableSpecies, sizeNow);
    if size(raw, 1) == 1 && sizeNow == 1
        raw = raw(:);
    end
    for row = 1:size(raw, 1)
        combo = raw(row, :);
        if all(ismember(requiredSpecies, combo))
            combinations{k} = combo;
            k = k + 1;
        end
    end
end
combinations = combinations(1:k-1);

if strcmpi(string(opts.outputFormat), "matrix")
    combinations = combinationCellsToMatrix(combinations);
elseif ~strcmpi(string(opts.outputFormat), "cell")
    error('GetAllCombination:UnknownOutputFormat', 'outputFormat must be cell or matrix.');
end
end

function species = normalizeSpeciesVector(input)
if isempty(input)
    species = [];
elseif isnumeric(input)
    species = reshape(input, 1, []);
elseif iscellstr(input) || isstring(input)
    species = cellstr(input);
    species = reshape(species, 1, []);
else
    error('GetAllCombination:InvalidSpecies', 'Species must be numeric, string, or cellstr.');
end
end

function total = countCombinations(availableSpecies, requiredSpecies, minSize, maxSize)
optionalCount = numel(availableSpecies) - numel(requiredSpecies);
requiredCount = numel(requiredSpecies);
total = 0;
for sizeNow = minSize:maxSize
    chooseOptional = sizeNow - requiredCount;
    if chooseOptional >= 0 && chooseOptional <= optionalCount
        total = total + nchoosek(optionalCount, chooseOptional);
    end
end
end
