% function to create a vocabulary from multiple text files under folders

function feat_vec = cse408_bow(filepath, voc)

[fid, msg] = fopen(filepath, 'rt');
error(msg);
% Get the first line from the file.
line = fgets(fid);

%create an array 
A = {};
words = {};

feat_vec = zeros(size(voc)); %Initialize the feature vector'

while line ~= -1
%PUT YOUR IMPLEMENTATION HERE
%grabbed this section of code fro my hw 1%
 %store to the end of the array
 A{end+1} = line;
    
%grab a new line
line = fgetl(fid);
end

%close the file%
fclose(fid);

%nested for loop to parse the sentences into their constituent words%
%outer loop cycles through the length of A%
for i=1:length(A)
    temp = A{i};
    j = 1;
    %inner while loop to store words in their own repecitve cell%
    while(j < length(A{i}))
        
        %store in storage%
        [storage,temp] = strtok(temp);
        
        %store to the end of words%
        words{end+1} = lower(storage);
        j = j+1;
    end
end
    for i=1:length(voc)
     counter=0;
     j = 1;
        while(j < length(words))
            if(strcmp(voc{i}, words{j}) == 1)
             counter=counter+1;
            end
            j = j+1;
        end
    feat_vec(i)=counter;
    end
end
