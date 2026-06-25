function sharedMets = createSharedEnvironment(modelInfos, sharedCompartment)
%CREATESHAREDENVIRONMENT Return canonical shared environment metabolite IDs.
sharedMets = {};
for i = 1:numel(modelInfos)
    exchange = detectExchangeReactions(modelInfos(i).model);
    for j = 1:numel(exchange.exchangeMetabolites)
        met = regexprep(exchange.exchangeMetabolites{j}, '\[[^\]]+\]$', '');
        met = regexprep(met, '_[A-Za-z][A-Za-z0-9]*$', '');
        sharedMets{end+1} = sprintf('%s[%s]', met, sharedCompartment); %#ok<AGROW>
    end
end
sharedMets = unique(sharedMets, 'stable');
end
