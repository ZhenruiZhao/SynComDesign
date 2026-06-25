function model = syncCobraConstraintFields(model)
%SYNCCOBRACONSTRAINTFIELDS Keep COBRA row-constraint fields dimensionally valid.
nMets = size(model.S, 1);
model.b = zeros(nMets, 1);
model.csense = repmat('E', nMets, 1);
model.rhs = zeros(nMets, 1);
model.sense = repmat('=', nMets, 1);
end
