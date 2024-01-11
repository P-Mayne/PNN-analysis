macro "batch_merge_channels"{
    setBatchMode(false);
    file1 = getDirectory("DAPI");
    //you can change the name of the inquiry to whatever wavelength you need, e.g. CY5
    list1 = getFileList(file1);
    //gets the list of files in the folder DAPI
    n1 = lengthOf(list1);
    //gets the number of files in folder DAPI, it should be the same as the number 
    //of files in folder GFP
    file2 = getDirectory("WFA");
    list2 = getFileList(file2); 
//    file3 = getDirectory("PARV");
//    list3 = getFileList(file3);
    file4 = getDirectory("Merge");
    //the output folder. When started first the number of files is 0
    list4 = getFileList(file4);
    n2 = lengthOf(list4);
    small = n1;
    //condition for for-loop
    for(i = n2; i < small; i++) {
    	print(i);
      //i will always follow the aborted number of merges, you might not have the problem, 
      //but with small memory and a huge set of images it is useful
      name = list2[i];
      open(file1 + list1[i]);
      open(file2 + list2[i]);
//      open(file3 + list3[i]);
//      run("Merge Channels...", "c1=[" + list2[i] + "] c2=[" + list3[i] + "] c3=[" + list1[i] + "] create");
		run("Merge Channels...", "c1=[" + list2[i] + "] c3=[" + list1[i] + "] create");
      run("16-bit");
//      run("Invert");
      saveAs("tif", file4 + name);
      run("Close All");
      }
}
