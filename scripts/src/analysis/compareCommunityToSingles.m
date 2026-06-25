function metrics = compareCommunityToSingles(communityResult, singleResults)
%COMPARECOMMUNITYTOSINGLES Compute best-member and additive comparisons.
total = communityResult.total_biomass;
members = communityResult.strain_names;
if ischar(members) || isstring(members)
    members = strsplit(char(members), ';');
end
singleBiomass = zeros(numel(members), 1);
singleN2O = zeros(numel(members), 1);
singleNO3 = zeros(numel(members), 1);
for i = 1:numel(members)
    row = strcmp(string(singleResults.strain), string(members{i}));
    if any(row)
        singleBiomass(i) = singleResults.total_biomass(find(row, 1));
        if ismember('n2o_uptake', singleResults.Properties.VariableNames)
            singleN2O(i) = singleResults.n2o_uptake(find(row, 1));
        end
        if ismember('nitrate_uptake', singleResults.Properties.VariableNames)
            singleNO3(i) = singleResults.nitrate_uptake(find(row, 1));
        end
    end
end
metrics.best_member_biomass = max(singleBiomass);
metrics.expected_additive_biomass = sum(singleBiomass);
metrics.biomass_gain_vs_best = safeDivide(total, metrics.best_member_biomass);
metrics.biomass_interaction_effect = total - metrics.expected_additive_biomass;
metrics.n2o_gain_vs_best = safeDivide(communityResult.n2o_uptake, max(singleN2O));
metrics.nitrate_gain_vs_best = safeDivide(communityResult.nitrate_uptake, max(singleNO3));
end
