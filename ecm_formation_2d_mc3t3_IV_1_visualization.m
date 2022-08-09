%Load, show and save images from dataset ecm-formation-2d-mc3t3-IV-1
%Data: Aurora: ecm-formation-2d-mc3t3-IV-1
%Journal notes: https://github.com/maglil/labbook/blob/main/ecm-formation-2d-mc3t3-IV.md

load = 0; %Set to 1 to load data
%Load data (Place data (.lif file) in  folder .\data)
if load %load data unless already loaded
    data = bfopen('.\data\ecm-formation-2d-mc3t3-IV-1.lif');
    %data is an nx4 cell array of n rows of images where the image data are stored in
    %the first position of the second argument. The other columns are metadata.
    series = 9;    
    ds = data{series,1};
    clear data
    im = ds (:,1);
    clear ds
    load = 0; %Set to not load next time
end

% The data array is interleaved 



%Make video
v = VideoWriter('movie.avi');
open(v);
for i=3:3:20
    img = rescale(double(im{i,1}));    
    writeVideo(v, img);   
end
 close(v);