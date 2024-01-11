
dir1 = getDirectory("Choose input directory");
dir2 = getDirectory("Choose output directory");
filelist = getFileList(dir1);
filesep = File.separator;
setBatchMode(true);

for(j=0;j<filelist.length;j++){
	inputfile = dir1 + filelist[j];
  	if(endsWith(inputfile,".tif") || endsWith(inputfile, ".tiff")){ 
  		open(inputfile);
  		run("Grays");
		run("32-bit");
		run("Make Inverse");
		run("Set...", "value=NaN stack");
  		run("Remove Overlay");
     	run("Split Channels");

		selectWindow("C1-" + filelist[j]);
		resetMinAndMax;
		saveAs("tif",  dir2 + filesep + "C1-" + filelist[j]);

		selectWindow("C2-" + filelist[j]);
		resetMinAndMax;
		saveAs("tif", dir2 + filesep + "C2-" + filelist[j]);
		
		selectWindow("C3-" + filelist[j]);
    	resetMinAndMax;
		saveAs("tif", dir2 + filesep + "C3-" + filelist[j]);

//		selectWindow("C4-" + filelist[j]);
//		resetMinAndMax;
//		saveAs("tif", dir2 + filesep + "C4-" + filelist[j]);
		
		close();
		}
	}
	
