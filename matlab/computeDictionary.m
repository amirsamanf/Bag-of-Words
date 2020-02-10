% Script to generate dictionary

alpha = 100;
K = 100;

paths = load('../data/traintest.mat');

harrisDict = getDictionary(paths.train_imagenames, alpha, K, 'harris');
save('dictionaryHarris_100.mat','harrisDict');
randomDict = getDictionary(paths.train_imagenames, alpha, K, 'random');
save('dictionaryRandom_100.mat','randomDict');

%%%%%% Different Parameters
% 
% alpha = 50;
% K = 100;
% 
% paths = load('../data/traintest.mat');
% 
% harrisDict = getDictionary(paths.train_imagenames, alpha, K, 'harris');
% save('dictionaryHarris_50.mat','harrisDict');
% randomDict = getDictionary(paths.train_imagenames, alpha, K, 'random');
% save('dictionaryRandom_50.mat','randomDict');
