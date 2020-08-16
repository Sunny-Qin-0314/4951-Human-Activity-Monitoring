# Human-Activity-Monitoring
The basic sequence of using this code is 
  input image -> Edge detection -> Edge thinning -> Edge Following -> expand
  
  After edge detection, you can see the edge image as the output, which may contain some isolated pixels.
  
  After edge thinning, you can see the thinned image with some end points in it. But no other isolated pixels.
  
  You can apply the thinned image to endJunctions.m to get the end points marked as green in the image. This can help you understand the code in edge following.
  
  Then, try to apply the thinned image to edge following and the output is the edgelist with all the coordinates of edge pixels in sequence.
  
  Use expand, and fill in the size of the gap, you will get a image with expanded lines. In this way, you can fill up the gap. But the shape of the object may change a little bit.  
  
