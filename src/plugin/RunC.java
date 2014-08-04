package plugin;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class RunC {
	
	public static String runc(String COMMAND) throws IOException
	{
			
			String str="";
	        Runtime run = Runtime.getRuntime();
	        Process pr = run.exec(COMMAND);
	        BufferedReader input = new BufferedReader(new InputStreamReader(pr.getInputStream()));
	        String line = null;
	        while((line=input.readLine())!=null){
	        //    System.out.println(line);
	            str=str+"\n"+line;
	        }
	        System.out.println(str);
	        return str;
	        
	      }
	        
	

}
