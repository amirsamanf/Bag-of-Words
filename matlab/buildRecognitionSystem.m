% Build recognition system

load('dictionaryHarris_100.mat','harrisDict');
load('dictionaryRandom_100.mat','randomDict');
load('../data/traintest.mat','train_imagenames','train_labels','mapping');
filterBank = createFilterBank();

% Harris
dictionary = harrisDict;
K = size(dictionary, 1);
T = length(train_imagenames);
trainFeatures = zeros(T, K);
trainLabels = zeros(T, 1);
for i = 1:T
    wordMap = load(['../data/', train_imagenames{i}(1:end-4), '_harris100.mat']);
    trainFeatures(i, :) = getImageFeatures(wordMap.wordMap, K);
    trainLabels(i) = train_labels(i);
end

save('visionHarris100.mat','dictionary','filterBank','trainFeatures','trainLabels')

% % Random
dictionary = randomDict;
K = size(dictionary, 1);
T = length(train_imagenames);
trainFeatures = zeros(T, K);
trainLabels = zeros(T, 1);
for i = 1:T
    wordMap = load(['../data/', train_imagenames{i}(1:end-4), '_random100.mat']);
    trainFeatures(i, :) = getImageFeatures(wordMap.wordMap, K);
    trainLabels(i) = train_labels(i);
end

save('visionRandom100.mat','dictionary','filterBank','trainFeatures','trainLabels')

