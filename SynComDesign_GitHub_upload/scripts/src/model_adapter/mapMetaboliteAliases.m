function aliasMap = mapMetaboliteAliases(aliasFile)
%MAPMETABOLITEALIASES Read canonical metabolite alias mappings.
if nargin < 1 || isempty(aliasFile)
    aliasFile = fullfile('config', 'metabolite_aliases.tsv');
end
if ~isfile(aliasFile)
    aliasMap = table(string.empty, string.empty, string.empty, ...
        'VariableNames', {'canonical_id','alias','category'});
    return
end
aliasMap = readTsvOrCsv(aliasFile);
end
