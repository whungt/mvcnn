function [ imdb ] = get_imdb( datasetName, varargin )
%GET_IMDB Get imdb structure for the specified dataset
% datasetName 
%   should be name of a directory under '/data'

datasetDir = fullfile('data',datasetName);
datasetFnName = ['setup_imdb_' datasetName];
imdbPath = fullfile(datasetDir,'imdb.mat');

if ~exist(datasetDir,'dir'), 
    error('Unknown dataset: %s', datasetName);
end

if exist(imdbPath,'file'), 
    imdb = load(imdbPath);
    if ~isempty(varargin), 
        warning('imdb loaded from %s, options might be ignored',imdbPath);
    end
else
    if exist([datasetFnName '.m'],'file'),
        imdb = eval([datasetFnName '(''' datasetDir ''',varargin{:})']);
    else
        imdb = setup_imdb_generic(datasetDir, varargin{:});
    end
    save(imdbPath,'-struct','imdb');
end

end

