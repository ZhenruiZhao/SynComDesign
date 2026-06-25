function tableOut = readTsvOrCsv(pathName)
%READTSVORCSV Read a TSV or CSV file into a table.
[~, ~, ext] = fileparts(pathName);
if any(strcmpi(ext, {'.tsv', '.txt'}))
    tableOut = readtable(pathName, 'FileType', 'text', 'Delimiter', '\t');
elseif strcmpi(ext, '.csv')
    tableOut = readtable(pathName);
else
    error('readTsvOrCsv:UnsupportedFormat', 'Unsupported table file: %s', pathName);
end
end
