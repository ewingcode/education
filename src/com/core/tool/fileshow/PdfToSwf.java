package com.core.tool.fileshow;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class PdfToSwf {

	public int convertPDF2SWF(String sourcePath, String destPath)
			throws IOException {
		String classPath = PdfToSwf.class.getResource("/").getPath().toString();
		String command = classPath + "File2Swf.bat " + sourcePath + " " + destPath;
		System.out.println("command��" + command);
		Process pro = Runtime.getRuntime().exec(command);
		// System.out.println(command);
		BufferedReader bufferedReader = new BufferedReader(
				new InputStreamReader(pro.getInputStream()));
		while (bufferedReader.readLine() != null) {
			String text = bufferedReader.readLine();
			System.out.println(text);
		}
		try {
			pro.waitFor();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return pro.exitValue();

	}

	public static void main(String[] args) {
		String sourcePath = "d:\\C122.pdf";
		String destPath = "d:\\C332.swf";
		try {
			System.out.println(new PdfToSwf().convertPDF2SWF(sourcePath,
					destPath));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}