dir1 = getDirectory("Choose input directory");
dir2 = getDirectory("Choose output directory");
filelist = getFileList(dir1);
filesep = File.separator;
setBatchMode(true);

for(j=0;j<filelist.length;j++){
	inputfile = dir1 + filelist[j];
  	if(endsWith(inputfile,".tif") || endsWith(inputfile, ".tiff")){ 
  		open(inputfile);
  		run("Top Hat...", "radius=50");
  		run("Gaussian Blur...", "radius=2");
//  		med = getValue("Median");
 // 		std = getValue("StdDev");
  	//	mean = getValue("Mean");
//		max = getValue("Max");
	//	setMinAndMax(med, (mean+(5*std)));
		run("16-bit");
	//	run("Subtract...", "value=5000");
//		run("Median...", "radius=2");
		saveAs("tif", dir2 + filesep + "NeuN" + filelist[j]);
		close();

		}
	}
	