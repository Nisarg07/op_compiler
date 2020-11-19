<?php

        $code=$_POST["code"];
        $file_name="beauty.c";
        $file_code = fopen($file_name, "w+");
	fwrite($file_code, $code);
        fclose($file_code);
        shell_exec('vim +"set syn=c" +"norm gg=G" -cwq '.$file_name);
        
        $content = file_get_contents($file_name);
        
        $arr = array("Edited"=> $content);
        header('Content-Type: application/json');
        echo json_encode($arr);
        
        if(file_exists($file_name)){
		unlink($file_name);
	}
	if(file_exists("beauty.c~")){
		unlink("beauty.c~");
	}
	if(file_exists(".beauty.c.un~")){
		unlink(".beauty.c.un~");
	}
?>