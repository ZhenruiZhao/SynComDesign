function community = validateCommunityModel(community)
%VALIDATECOMMUNITYMODEL Validate community model dimensions and IDs.
warnings = {};
errors = {};
if size(community.S, 1) ~= numel(community.mets)
    errors{end+1} = 'S rows do not match metabolites.'; %#ok<AGROW>
end
if size(community.S, 2) ~= numel(community.rxns)
    errors{end+1} = 'S columns do not match reactions.'; %#ok<AGROW>
end
if numel(unique(community.rxns)) ~= numel(community.rxns)
    errors{end+1} = 'Duplicate community reaction IDs.'; %#ok<AGROW>
end
if numel(unique(community.mets)) ~= numel(community.mets)
    errors{end+1} = 'Duplicate community metabolite IDs.'; %#ok<AGROW>
end
community.syncomdesign.validation = struct('isValid', isempty(errors), ...
    'errors', {errors}, 'warnings', {warnings});
end
