dir1 = getDirectory("Choose input directory");
dir2 = getDirectory("Choose output directory");
filelist = getFileList(dir1);
filesep = File.separator;
setBatchMode(false);

for(j=0;j<filelist.length;j++){
	inputfile = dir1 + filelist[j];
  	if(endsWith(inputfile,".tif")){ 
  		open(inputfile);
		run("Threshold...");
		setThreshold(1, 65535);
		setOption("BlackBackground", false);
		run("Convert to Mask");
		run("Adjustable Watershed");
		waitForUser("Adjust tolerance... \nPress OK to continue.");
//		run("Watershed");
		run("16-bit");
//		run("Invert");
		saveAs("tif", dir2 + filesep + "outlines" + filelist[j]);
		close();
  		}
  	}





