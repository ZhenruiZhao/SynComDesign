function exchange = detectExchangeReactions(model)
%DETECTEXCHANGEREACTIONS Detect exchange reactions and their metabolites.
%
%   Detection prefers COBRA findExcRxns/findSExRxnInd when present and falls
%   back to R_EX_/EX_ identifiers or single external-metabolite reactions.

rxns = safeCellstr(model.rxns);
isExchange = false(numel(rxns), 1);

if exist('findExcRxns', 'file') == 2
    try
        cobraExchange = findExcRxns(model);
        if islogical(cobraExchange)
            isExchange = isExchange | cobraExchange(:);
        else
            isExchange(cobraExchange) = true;
        end
    catch
    end
end
if exist('findSExRxnInd', 'file') == 2
    try
        [~, selExchange] = findSExRxnInd(model);
        if islogical(selExchange)
            isExchange = isExchange | selExchange(:);
        else
            isExchange(selExchange) = true;
        end
    catch
    end
end

stoichCount = full(sum(model.S ~= 0, 1))';
singleExternal = false(numel(rxns), 1);
for r = 1:numel(rxns)
    if stoichCount(r) == 1
        metIdx = find(model.S(:, r) ~= 0, 1);
        if ~isempty(metIdx)
            met = char(model.mets(metIdx));
            singleExternal(r) = ~isempty(regexp(met, '(\[[eu]\]$|_[eu]$)', 'once'));
        end
    end
end

isExchange = isExchange | startsWith(rxns, 'EX_') | startsWith(rxns, 'R_EX_') | singleExternal;
idx = find(isExchange);
exchangeRxns = rxns(idx);
exchangeMets = cell(numel(idx), 1);
for i = 1:numel(idx)
    metIdx = find(model.S(:, idx(i)) ~= 0);
    if isempty(metIdx)
        exchangeMets{i} = '';
    else
        exchangeMets{i} = char(model.mets(metIdx(1)));
    end
end

exchangeMap = table(exchangeRxns(:), exchangeMets(:), idx(:), ...
    'VariableNames', {'exchange_rxn','metabolite','rxn_index'});
exchange = struct('exchangeRxns', {exchangeRxns(:)'}, ...
    'exchangeMetabolites', {exchangeMets(:)'}, 'exchangeMap', exchangeMap);
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
