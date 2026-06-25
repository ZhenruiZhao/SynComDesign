function mapping = mapCommunityReactions(communityModel)
%MAPCOMMUNITYREACTIONS Return reaction mapping stored on a community model.
if isfield(communityModel, 'syncomdesign') && isfield(communityModel.syncomdesign, 'reactionMap')
    mapping = communityModel.syncomdesign.reactionMap;
else
    mapping = table();
end
end
