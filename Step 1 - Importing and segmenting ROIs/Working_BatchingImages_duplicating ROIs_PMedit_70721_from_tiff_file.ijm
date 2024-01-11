dir1 = getDirectory("Choose input directory");
dir2 = getDirectory("Select output directory");
filelist = getFileList(dir1);
filesep = File.separator;
setBatchMode(false);

for(j=0;j<filelist.length;j++){
	inputfile = dir1 + filelist[j];
  	if(endsWith(inputfile,".tiff")){ 
  		open(inputfile);
  		if(bitDepth()==8){
  			run("Stack to RGB");
			}
  		run("Rotate 90 Degrees Right");
		run("RGB Color");
  		run("Make Composite");
  		run("16-bit");
  		saveAs("tif", dir2 + filesep + filelist[j]);
		name = getTitle();
		name = replace(name, ".tiff", "");
		run("Remove Overlay");
  		roiPath = File.openDialog("Pick your ROI set");
  		roiManager("reset");
  		roiManager("open", roiPath); 

		n = roiManager('count');
		roiManager("Show All");
		roiManager("List");
		Table.sort("Y");
		t1 = Table.title;
		roinames = newArray(n);
		for (i = 0; i < n; i++) {
			roinames[i] = Table.getString("Name", i);
		}
		close(t1);
		
		numbers = newArray(n);
		for (i = 0; i < n; i++) {
			numbers[i] = i;
		}

		roiManager("Show All");
		waitForUser("Move ROI to correct position... \nPress OK to continue.");
		roiManager("save", dir2 + filelist[j] +'_RoiSet.zip'); 
		roiManager("select", numbers);

		filename=newArray(n);
		for (i = 0; i < n; i++) {
			roiManager('select', i);
			roi_name = Roi.getName();
			fielistshort = replace(filelist[j], ".tif", "_");
			filename[i] = fielistshort + roi_name + ".tif";
			//run("Make Substack...", "channels=3 slices=1");
			run("Duplicate...", "duplicate");
			setBackgroundColor(0, 0, 0);
			run("Clear Outside", "stack");
			saveAs("tif", dir2 + filesep + "Roi_" + filename[i]);
			run("Close");
			}
			
		run("Close All");
	}
}
	
