function compartments = detectCompartments(model)
%DETECTCOMPARTMENTS Detect metabolite compartment suffixes in a COBRA model.
mets = cellstr(model.mets);
compartments = {};
for i = 1:numel(mets)
    token = regexp(mets{i}, '\[([^\]]+)\]$', 'tokens', 'once');
    if isempty(token)
        token = regexp(mets{i}, '_([A-Za-z][A-Za-z0-9]*)$', 'tokens', 'once');
    end
    if ~isempty(token)
        compartments{end+1} = token{1}; %#ok<AGROW>
    end
end
compartments = unique(compartments, 'stable');
end
