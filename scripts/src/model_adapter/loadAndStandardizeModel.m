function modelInfo = loadAndStandardizeModel(modelPath, config, strainName)
%LOADANDSTANDARDIZEMODEL Load a COBRA model and attach SynComDesign metadata.
%
%   modelInfo = loadAndStandardizeModel(modelPath, config, strainName) reads a
%   .xml, .sbml, .mat, or .json model using readCbModel when available. It then
%   detects biomass and exchange reactions and stores SynComDesign metadata in
%   model.syncomdesign.

if nargin < 3 || isempty(strainName)
    [~, strainName] = fileparts(modelPath);
end
if exist('readCbModel', 'file') ~= 2
    error('loadAndStandardizeModel:MissingCOBRA', 'COBRA Toolbox readCbModel is required to load %s.', modelPath);
end

model = readCbModel(modelPath);
model = normalizeReactionIds(model);
biomassOverrides = readBiomassOverrides(config.models.biomass_reactions_file);
override = '';
if isfield(biomassOverrides, matlab.lang.makeValidName(strainName))
    override = biomassOverrides.(matlab.lang.makeValidName(strainName));
end
biomass = detectBiomassReaction(model, override);
exchange = detectExchangeReactions(model);
validation = validateCarveMeModel(model, biomass, exchange, config);

model.syncomdesign = struct();
model.syncomdesign.strainName = strainName;
model.syncomdesign.modelPath = modelPath;
model.syncomdesign.biomassRxn = biomass.biomassRxn;
model.syncomdesign.biomassCandidates = biomass.candidates;
model.syncomdesign.exchangeRxns = exchange.exchangeRxns;
model.syncomdesign.exchangeMetabolites = exchange.exchangeMetabolites;
model.syncomdesign.exchangeMap = exchange.exchangeMap;
model.syncomdesign.validation = validation;

modelInfo = struct('name', strainName, 'path', modelPath, 'model', model, ...
    'biomassRxn', biomass.biomassRxn, 'exchange', exchange, ...
    'validation', validation);
end

function overrides = readBiomassOverrides(pathName)
overrides = struct();
if isempty(pathName) || ~isfile(pathName)
    return
end
lines = regexp(fileread(pathName), '\r?\n', 'split');
for i = 2:numel(lines)
    line = strtrim(lines{i});
    if isempty(line)
        continue
    end
    parts = strsplit(line, sprintf('\t'));
    if numel(parts) < 2
        continue
    end
    key = matlab.lang.makeValidName(strtrim(parts{1}));
    overrides.(key) = strtrim(parts{2});
end
end
