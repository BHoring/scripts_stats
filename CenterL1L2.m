% Returns variables properly centered for HLM analyses, distinguishing first and second level variance, based on
% Hofmann, D. A., & Gavin, M. B. (1998). Centering decisions in hierarchical linear models: Implications for research in organizations. Journal of Management, 24(5), 623–641. doi: 10.1177/014920639802400504
%
% data = CenterL1L2(data,sbVarTag,varList)
% data      - data (table)
% sbVarTag  - column name of subject (or more generally, first level entity) identifier (string)
% varList   - column name(s) of to-be-centered variable(s) (cell array)
% 
% Version: 1.1
% Author: Björn Horing, bjoern.horing@gmail.com
% Date: 2021-06-15
%
% Version notes
% 1.1
% - function description, comments for Git

function data = CenterL1L2(data,sbVarTag,varList)

    allSbs = unique(data.(sbVarTag));
    allSbs = allSbs(~isnan(allSbs));
    
    for v = 1:numel(varList)
        varName = varList{v};

        for sb = 1:numel(allSbs)
            sbId = allSbs(sb);        
            data.(['m1' varName])(data.SbId==sbId) = mean(data.(varName)(data.SbId==sbId),'omitnan'); % subject mean
        end
        data.(['c1' varName]) = data.(varName)-data.(['m1' varName]); % L1 centered
        data.(['m2' varName]) = repmat(mean(data.(['m1' varName]),'omitnan'),size(data,1),1); % grand mean
        data.(['c2' varName]) = data.(['m1' varName])-mean(data.(['m2' varName]),'omitnan'); % L2 centered
    end
    