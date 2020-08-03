% function to create a vocabulary from multiple text files under folders

function voc = buildVoc(folder, voc)

stopword = {'ourselves', 'hers', 'between', 'yourself', 'but', 'again', 'there', ...
    'about', 'once', 'during', 'out', 'very', 'having', 'with', 'they', 'own', ...
    'an', 'be', 'some', 'for', 'do', 'its', 'yours', 'such', 'into', ...
    'of', 'most', 'itself', 'other', 'off', 'is', 's', 'am', 'or', ...
    'who', 'as', 'from', 'him', 'each', 'the', 'themselves', 'until', ...
    'below', 'are', 'we', 'these', 'your', 'his', 'through', 'don', 'nor', ...
    'me', 'were', 'her', 'more', 'himself', 'this', 'down', 'should', 'our', ...
    'their', 'while', 'above', 'both', 'up', 'to', 'ours', 'had', 'she', 'all', ...
    'no', 'when', 'at', 'any', 'before', 'them', 'same', 'and', 'been', 'have', ...
    'in', 'will', 'on', 'does', 'yourselves', 'then', 'that', 'because', ...
    'what', 'over', 'why', 'so', 'can', 'did', 'not', 'now', 'under', 'he', ...
    'you', 'herself', 'has', 'just', 'where', 'too', 'only', 'myself', ...
    'which', 'those', 'i', 'after', 'few', 'whom', 't', 'being', 'if', ...
    'theirs', 'my', 'against', 'a', 'by', 'doing', 'it', 'how', ...
    'further', 'was', 'here', 'than'}; % define English stop words, from NLTK



files = dir(fullfile(folder,'*.txt'));

for file = files'
    [fid, msg] = fopen(fullfile(folder,file.name), 'rt', 'n', 'UTF-8');
    error(msg);
    line = fgets(fid); % Get the first line from
    line = erasePunctuation(line);
    
     % the file.
    while line ~= -1
    %PUT YOUR IMPLEMENTATION HERE
    % get first word
        [token, remain] = strtok(line);
        
        %while loop to run until there is no remainder
        while (~strcmp(remain, ""))
            % lowercase the string
            token = lower(token);
            
            % remove punctuation from token in the line%
            token = regexprep(token, '[.]', "");
            token = regexprep(token, '[,]', "");
            token = regexprep(token, '[!]', "");
            token = regexprep(token, '[?]', "");
            token = regexprep(token, '[:]', "");
            token = regexprep(token, '[+]', "");
            token = regexprep(token, '[""]', "");
            token = regexprep(token, "[']", "");
            token = regexprep(token, '[-]', "");
            token = regexprep(token, '[(]', "");
            token = regexprep(token, '[)]', "");
            token = regexprep(token, '[+]', "");
            token = regexprep(token, '[*]', "");
            token = regexprep(token, '[/]', "");
            token = regexprep(token, '[0-9]', "");
            
            %remove the whitespace and the stopwords%
            if (ismember({token}, "") || ismember({token}, stopword))
                
                %if there is a remainder get the next word from the
                %remainder
                if (~strcmp(remain, ""))
                    % get the next word
                    [token, remain] = strtok(remain);
                end
            else
                %add the token to the end of the the cell array
                voc = [voc,char(token)];
                
                %if there is a remainder get the next word from the
                %remainder
                if (~strcmp(remain, ""))
                    [token, remain] = strtok(remain);
                end
            end
        end
        
        % get the next line available
        line = fgets(fid);
    
    end
    fclose(fid);
    
    %use unique function to account for duplicates%
    voc = unique(voc);
end