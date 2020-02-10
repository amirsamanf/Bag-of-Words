% evaluateRecognitionSystem_kNN Script

load('traintest.mat', 'test_imagenames', 'test_labels', 'train_imagenames', 'train_labels', 'mapping');
harris = load('visionHarris100.mat');
% random = load('visionRandom100.mat');

accuracy = zeros(1,40);
C = zeros(8,8,40);
for k = 1:40
    method = 'chi2';
    l = length(test_imagenames);
    K = size(harris.dictionary, 1);
    predictionVect = zeros(1, l);
    for i = 1:l
        distances = zeros(1, length(train_imagenames));
        wordMap = load(['../data/', test_imagenames{i}(1:end-4), '_harris100.mat']);
        testFeatures = getImageFeatures(wordMap.wordMap, K);
        testLabel = test_labels(i);

        for j = 1:length(train_imagenames)
            trainFeatures = harris.trainFeatures(j, :);
            distances(j) = getImageDistance(trainFeatures, testFeatures, method);
        end

        [~, ind] = mink(distances, k);
        predictionLabels = train_labels(ind);
        countVotes = sum(predictionLabels == predictionLabels');

        [~, maxVoteInd] = max(countVotes);
        predictionLabel = predictionLabels(maxVoteInd);
        if predictionLabel == testLabel
           predictionVect(i) = 1; 
        end
        C(testLabel, predictionLabel, k) = C(testLabel, predictionLabel, k) + 1;
    end
    
    correct = sum(predictionVect);
    accuracy(k) = correct / l;
    
end

[maxAccuracy,maxk] = max(accuracy);
k = (1:40);
figure
plot(k, accuracy);
title('k vs. Accuracy for Harris Method using Chi Squared Distance')
xlabel('k')
ylabel('Accuracy')

fprintf('Maximum accuracy occurs at k=%d with accuracy of %f | Confusion matrix below:\n',maxk,maxAccuracy)
disp(C(:,:,maxk));






    
    