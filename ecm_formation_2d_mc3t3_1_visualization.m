%Load, show and save images from dataset ecm-formation-2d-mc3t3-1
%Data: Aurora: ecm-formation-2d-mc3t3-1
%Journal notes: https://github.com/NLOM-NTNU-PI/labbook/blob/main/ecm-formation-2d-mc3t3

%Place data (.lif file) in  folder .\data
%Load data
if ~(exist('data','var')) %load data unless already loaded
    data = bfopen('.\data\ecm-formation-2d-mc3t3-1b.lif');
end
%data is an nx4 cell array of n rows of images where the image data are stored in
%the first position of the second argument. The other columns are metadata.

na = [1,2,3,4,5,6]; %n = 1-6 brightfield images, one channel
nb = [7,8,11,12,13]; %n = 7-8 NLOM images, 4 channels, Ch4: SHG
nc = [9,10,14]; %n = 9,10 z-stacks/t-stacks, 4 channels, interleaved
nd = [15,16,17]; % n = 15 NLOM image, 2 channels
ne = [18]; % n = 18 z-stack, 2 channels
n = 11;
if any(n==na)
    img = data{n,1}{1,1};
    imshow(img,[])
elseif any(n==nb)
    img = data{n,1}{4,1}; 
    imshow(img,[]) 
elseif any(n==nc)
    stack = data{n,1}(:,1);  
    img_stack = stack(4:4:end,1);
    montage(img_stack,'DisplayRange',[])
elseif any(n==nd)
    img = data{n,1}{2,1}; 
    imshow(img,[])
elseif any(n==ne)
    stack = data{n,1}(:,1);  
    img_stack = stack(2:2:end,1);
    montage(img_stack,'DisplayRange',[])
end
%close all
%imshow(img,[])