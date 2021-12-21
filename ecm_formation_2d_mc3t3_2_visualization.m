%Load, show and save images from dataset ecm-formation-2d-mc3t3-2
%Data: Aurora: ecm-formation-2d-mc3t3-1
%Journal notes: https://github.com/NLOM-NTNU-PI/labbook/blob/main/ecm-formation-2d-mc3t3

%Place data (.lif file) in  folder .\data\
%Load data
if ~(exist('data','var')) %load data unless already loaded
    data = bfopen('.\data\ecm-formation-2d-mc3t3-2\ecm-formation-2d-mc3t3-2.lif');
end
%data is an nx4 cell array of n rows of images where the image data are stored in
%the first position of the second dimension (columns). The other columns are metadata.
%Note: This are not the same as the numbers in the journal, see metadata
%for series number in the lif file which corresponds to journal notes
na = [1,2,3]; %n = 1-3 NLOM images, 1 channel (BSHG), three different depths.
nb = [4]; %n = 1-3 NLOM images, 2 channels (TPEF,BSHG), three different depths.
%24-26 is -P/-AA, 27-28 is -P
%26 probably had a detector shutdown on SHG channel
nc = [5:31]; %n = 5-31 NLOM images, 3 channels (FSHG,TPEF,BSHG), three different depths.
nd = [32:35,38]; % n = 32 NLOM images, 3 channels (FSHG,TPEF,BSHG)
ne = [36,37,39]; % n = 32 NLOM images, 3 channels (FSHG,TPEF,BSHG), z-series 26 slices.
% ne = [18]; % n = 18 z-stack, 2 channels
n = 27;
if any(n==na)
     img = data{n,1}{3,1};
     imshow(img,[])
elseif any(n==nb)
     temp = data{n,1}{1,1};
     img = zeros([size(temp),3],class(temp));
     img(:,:,1) = temp; 
     img(:,:,2) = data{n,1}{2,1}; 
     image(img)
elseif any(n==nc)
     temp = data{n,1}{1,1};
     img = zeros([size(temp),3],class(temp));   
     img(:,:,1) = data{n,1}{2,1}; %TPEF
     img(:,:,2) = data{n,1}{3,1}; %BSHG
     img(:,:,3) = temp; %FSHG
     image(img)     
elseif any(n==nd)
     temp = data{n,1}{1,1};
     img = zeros([size(temp),3],class(temp));   
     img(:,:,1) = data{n,1}{2,1}; %TPEF
     img(:,:,2) = data{n,1}{3,1}; %BSHG
     img(:,:,3) = temp; %FSHG
     image(img)  
elseif any(n==ne)
     dim = size(data{n,1});
     len = (dim(1)/3);
     
     temp = data{n,1}{1,1};
     
     img_series = zeros([size(temp),3,len],class(temp));
     for i = [1:len]
        img_series(:,:,1,i) = data{n,1}{i*3-1,1};
        img_series(:,:,2,i) = data{n,1}{i*3,1};
        img_series(:,:,3,i) = data{n,1}{i*3-2,1};
     end
     mov = immovie(img_series);
     implay(mov)
end

% elseif any(n==nc)
%     stack = data{n,1}(:,1);  
%     img_stack = stack(4:4:end,1);
%     montage(img_stack,'DisplayRange',[])
% elseif any(n==nd)
%     img = data{n,1}{2,1}; 
%     imshow(img,[])
% elseif any(n==ne)
%     stack = data{n,1}(:,1);  
%     img_stack = stack(2:2:end,1);
%     montage(img_stack,'DisplayRange',[])
% end
%close all
%imshow(img,[])