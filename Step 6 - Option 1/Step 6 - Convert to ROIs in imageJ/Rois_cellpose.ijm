dir1 = getDirectory("Choose input directory");
dir2 = getDirectory("Choose output directory");
filelist = getFileList(dir1);
filesep = File.separator;
setBatchMode(true);

for(j=0;j<filelist.length;j++){
	inputfile = dir1 + filelist[j];
  	if(endsWith(inputfile,".tif")){ 
  		open(inputfile);
//		run("Threshold...");
//		setThreshold(1, 255);
//		setOption("BlackBackground", false);
		run("Convert to Mask");
		run("Create Selection");
		run("Analyze Particles...", "size=200-Infinity show=Masks display add");
		run("16-bit");
		saveAs("tif", dir2 + filesep + filelist[j]);
		roiManager("save", dir2 + filelist[j] +'_RoiSet.zip');
		roiManager("reset");
			}
		close("*");

		}
