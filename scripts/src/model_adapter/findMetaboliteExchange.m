function rxnId = findMetaboliteExchange(model, aliases)
%FINDMETABOLITEEXCHANGE Find an exchange reaction for any metabolite alias.
%
%   rxnId = findMetaboliteExchange(model, aliases) checks exchange reaction IDs,
%   exchange metabolites, and compartment-stripped metabolite IDs.

if ischar(aliases) || isstring(aliases)
    aliases = cellstr(aliases);
end
exchange = detectExchangeReactions(model);
rxnId = '';
for i = 1:numel(exchange.exchangeRxns)
    rxn = exchange.exchangeRxns{i};
    met = exchange.exchangeMetabolites{i};
    metBase = stripCompartment(met);
    rxnBase = stripSbmlPrefix(rxn);
    metNorm = stripSbmlPrefix(met);
    metBase = stripSbmlPrefix(metBase);
    if any(strcmpi(aliases, rxn)) || any(strcmpi(aliases, rxnBase)) ...
            || any(strcmpi(aliases, met)) || any(strcmpi(aliases, metNorm)) ...
            || any(strcmpi(aliases, metBase))
        rxnId = rxn;
        return
    end
end
end

function base = stripCompartment(met)
base = regexprep(char(met), '\[[^\]]+\]$', '');
base = regexprep(base, '_[A-Za-z][A-Za-z0-9]*$', '');
end

function value = stripSbmlPrefix(value)
value = regexprep(char(value), '^[RM]_', '');
end
