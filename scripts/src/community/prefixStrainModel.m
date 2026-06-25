function result = prefixStrainModel(model, strainName, sharedCompartment)
%PREFIXSTRAINMODEL Prefix model IDs and map exchange metabolites to one pool.

safeName = matlab.lang.makeValidName(strainName);
exchange = detectExchangeReactions(model);
exchangeRxns = exchange.exchangeRxns;
exchangeMets = exchange.exchangeMetabolites;

newMets = cell(size(model.mets));
metRows = cell(numel(model.mets), 4);
for i = 1:numel(model.mets)
    sourceMet = char(model.mets{i});
    exIdx = find(strcmp(exchangeMets, sourceMet), 1);
    if ~isempty(exIdx)
        canonical = canonicalMetId(sourceMet);
        newMets{i} = sprintf('%s[%s]', canonical, sharedCompartment);
        role = 'shared_environment';
    else
        newMets{i} = [safeName, '__', sourceMet];
        role = 'strain_internal';
    end
    metRows(i, :) = {newMets{i}, strainName, sourceMet, role};
end

newRxns = cell(size(model.rxns));
rxnRows = cell(numel(model.rxns), 4);
for i = 1:numel(model.rxns)
    sourceRxn = char(model.rxns{i});
    newRxns{i} = [safeName, '__', sourceRxn];
    if any(strcmp(exchangeRxns, sourceRxn))
        role = 'exchange';
    else
        role = 'strain_internal';
    end
    rxnRows(i, :) = {newRxns{i}, strainName, sourceRxn, role};
end

prefixed = model;
prefixed.mets = newMets(:);
prefixed.rxns = newRxns(:);

biomassRxn = '';
if isfield(model, 'syncomdesign') && isfield(model.syncomdesign, 'biomassRxn') && ~isempty(model.syncomdesign.biomassRxn)
    biomassRxn = [safeName, '__', model.syncomdesign.biomassRxn];
end

result = struct('model', prefixed, 'reactionMap', ...
    cell2table(rxnRows, 'VariableNames', {'community_rxn','strain','source_rxn','role'}), ...
    'metaboliteMap', cell2table(metRows, 'VariableNames', {'community_met','strain','source_met','role'}), ...
    'biomassRxn', biomassRxn);
end

function canonical = canonicalMetId(met)
canonical = regexprep(char(met), '\[[^\]]+\]$', '');
canonical = regexprep(canonical, '_[A-Za-z][A-Za-z0-9]*$', '');
canonical = regexprep(canonical, '^M_', '');
end
