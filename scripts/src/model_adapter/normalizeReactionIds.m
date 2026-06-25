function model = normalizeReactionIds(model)
%NORMALIZEREACTIONIDS Normalize reaction and metabolite ID containers.
%
%   The function keeps IDs unchanged, but ensures they are cell arrays of char
%   values and rejects missing or duplicate IDs.

model.rxns = safeCellstr(model.rxns);
model.mets = safeCellstr(model.mets);
if any(cellfun(@isempty, model.rxns))
    error('normalizeReactionIds:EmptyReactionId', 'Reaction IDs must not be empty.');
end
if any(cellfun(@isempty, model.mets))
    error('normalizeReactionIds:EmptyMetaboliteId', 'Metabolite IDs must not be empty.');
end
if numel(unique(model.rxns)) ~= numel(model.rxns)
    error('normalizeReactionIds:DuplicateReactionId', 'Reaction IDs must be unique.');
end
if numel(unique(model.mets)) ~= numel(model.mets)
    error('normalizeReactionIds:DuplicateMetaboliteId', 'Metabolite IDs must be unique.');
end
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
