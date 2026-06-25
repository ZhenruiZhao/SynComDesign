function writeTableBoth(tableData, outputDir, baseName)
%WRITETABLEBOTH Write a table as TSV and CSV.
ensureDirectory(outputDir);
writetable(tableData, fullfile(outputDir, baseName + ".tsv"), 'FileType', 'text', 'Delimiter', '\t');
writetable(tableData, fullfile(outputDir, baseName + ".csv"));
end
