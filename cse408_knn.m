% function to run KNN classification
function pred_label = cse408_knn(test_feat, train_label, train_feat, k, DstType)

    
if DstType == 1 %SSD
    %PUT YOUR CODE HERE
    
    %create a zero matrix of the same size as test_feat
    ssd = zeros(size(test_feat));
    
    %loop throught the length of the train_label to sum the distances
    i = 1;
    while (i < length(train_label))
        
        %create a secondary zero matrix of the same size as test_feat that
        subtract = zeros(size(test_feat));
        
        %loop through the test feat length and calculate the difference
        %between the vectors%
        j = 1;
        
        %loop through the length of test_feat and calculate the smallest
        %distance 
        while(length(test_feat) <= 1 && j <= length(test_feat))
            
            %calculate the distance
            sd = (test_feat(i,1) - train_feat(j,i));
            
            %square the distance
            sd = power(sd, 2);
            
            %add distance into the matrix
            subtract(j) = sd;
            j = j+1;
        end
        
        %sum the distances and add them to the ssd vector at the index of i
        ssd(i) = sum(subtract);
        i = i+1;
    end
    
    
%create a zero matrix of the same size as test_feat
%ssd = nonzeros(ssd);
elseif DstType == 2 %Angle Between Vectors
    %PUT YOUR CODE HERE
    
    %create j variable
    j = 1;
    %loop through the column size of train_feat 
    %calculate the angle between the vectors
    while(j <= size(train_feat,2))
        %store the calculations for cosine in variables
        a = train_feat(:,j);
        a1 = dot(a,test_feat);
        b = norm(train_feat(:,j));
        c = norm(test_feat);
        c = b*c;
    
        %calculate the cosine
        cos = a1/c;
        
        %use the inverse cosine to get the angle
        ssd(j) = acosd(cos);
        
        %increment j
        j = j+1;
    end
elseif DstType == 3 %Number of words in common
    %PUT YOUR CODE HERE 
    ssd = zeros(size(train_feat,2));
    
    %i variable for looping
    i = 1;
    
    %loop through the column size of train_feat 
    while (i <= size(train_feat,2))
        a = 0;
        
        %variable for second loop
        j = 1;
        
        %loop through the row size of train_feat.
        while (j <= size(train_feat,1))
            %if else statement to get the greatest number of common words
            if train_feat(j,i)<test_feat(j,1)
                a = a + train_feat(j,i);
            else
                a = a + test_feat(j,1);
            end
        j = j+1;
        end
        ssd(i) = a;
        i = i+1;
    end
    ssd = -ssd; % Why minus?
end



%Find the top k nearest neighbors, and do the voting. 

[B,I] = sort(ssd);

posCt=0;
negCt=0;
for ii = 1:k
    if train_label(I(ii)) == 1
        posCt = posCt + 1;
    elseif train_label(I(ii)) == 0
        negCt = negCt + 1;
    end    
end

if posCt >= negCt
    pred_label = 1;
else
    pred_label = 0;
end