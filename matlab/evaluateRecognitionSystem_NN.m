% evaluateRecognitionSystem_NN Script

load('traintest.mat', 'test_imagenames', 'test_labels', 'train_imagenames', 'train_labels', 'mapping');
harris = load('visionHarris100.mat');
random = load('visionRandom100.mat');

for jj = 1:4
    if jj == 1
        method = 'chi2';
        featureString = 'harris';
        featuresType = harris;
        featuresFile = '_harris100.mat';
    elseif jj == 2
        method = 'euclidean';
        featureString = 'harris';
        featuresType = harris;
        featuresFile = '_harris100.mat';
    elseif jj == 3
        method = 'chi2';
        featureString = 'random';
        featuresType = random;
        featuresFile = '_random100.mat';
    elseif jj == 3
        method = 'euclidean';
        featureString = 'random';
        featuresType = random;
        featuresFile = '_random100.mat';
    end
    
    C = zeros(8,8,4);
    l = length(test_imagenames);
    K = size(featuresType.dictionary, 1);
    predictionVect = zeros(1, l);
    for i = 1:l
        distances = zeros(1, length(train_imagenames));
        wordMap = load(['../data/', test_imagenames{i}(1:end-4), featuresFile]);
        testFeatures = getImageFeatures(wordMap.wordMap, K);
        testLabel = test_labels(i);

        for j = 1:length(train_imagenames)
            trainFeatures = featuresType.trainFeatures(j, :);
            distances(j) = getImageDistance(trainFeatures, testFeatures, method);
        end

        [~, ind] = min(distances);
        predictionLabel = train_labels(ind);
        if predictionLabel == testLabel
           predictionVect(i) = 1; 
        end
        C(testLabel, predictionLabel, jj) = C(testLabel, predictionLabel, jj) + 1;
    end

    correct = sum(predictionVect);
    accuracy = correct / l;
    
    fprintf('Accuracy of %s using metric %s is: %f | Confusion matrix below:\n',featureString,method,accuracy)
    disp(C(:,:,jj));
end





