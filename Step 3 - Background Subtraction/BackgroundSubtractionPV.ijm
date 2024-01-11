dir1 = getDirectory("Choose input directory");
dir2 = getDirectory("Choose output directory");
filelist = getFileList(dir1);
filesep = File.separator;
setBatchMode(true);

for(j=0;j<filelist.length;j++){
	inputfile = dir1 + filelist[j];
  	if(endsWith(inputfile,".tif") || endsWith(inputfile, ".tiff")){ 
  		open(inputfile);
  		med = getValue("Median");
  		std = getValue("StdDev");
  		mean = getValue("Mean");
		max = getValue("Max");
		setMinAndMax(med, (mean+(5*std)));
		run("16-bit");
		run("Subtract...", "value=2000");
	//	run("Median...", "radius=5");
		saveAs("tif", dir2 + filesep + "PV" + filelist[j]);
		close();

		}
	}
	