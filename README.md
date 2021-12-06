# IntensityBasedComposition
EE456_flip.m reflects the folder images vertically. This is used to make sample images match the orientation of the training image. Sample images are taken from 'F:\coursesUND\EE456\Project\imageData\' and are overwritten.

EE456_rotate.m finds the coordinate of the highest intesity pixels of the ecadherin signal (the top arc) and fits a line throught the points. Each image is then rotate by an angle that makes this fitted line horizontal. Rotated images are saved in 'F:\coursesUND\EE456\Project\rotData\'.

EE456_project.m performs the Dorsal-ventral boundary detection, gaussian blur, binary masking, and histogram plotting for each sample in the folder 'F:\coursesUND\EE456\Project\rotData\'.
