package com.core.tool.fileshow;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.ConnectException;

import com.artofsolving.jodconverter.DocumentConverter;
import com.artofsolving.jodconverter.openoffice.connection.OpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.connection.SocketOpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.converter.OpenOfficeDocumentConverter;

public class FileToSwfTool {
	final static String BATFILE = PdfToSwf.class.getResource("/").getPath()
			.toString()
			+ "File2Swf.bat";
	private File sourceFile;
	private File destPdfFile;
	private File destSwfFile;
	private static OpenOfficeConnection connection;
	private static final FileToSwfTool fileToSwfUtil = new FileToSwfTool();

	private FileToSwfTool() {

	}

	public static FileToSwfTool getFileToSwfTool() {
		return fileToSwfUtil;
	}

	public File convert(File sourceFile) throws IOException {

		this.sourceFile = sourceFile;
		if (this.sourceFile!=null && this.sourceFile.isFile()) {
			String fileName =  sourceFile.getAbsolutePath();
			String simpleName = sourceFile.getName(); 
			destPdfFile = new File(fileName.replace(simpleName, System.currentTimeMillis()+"_pdf.pdf"));
			destSwfFile = new File(fileName.replace(simpleName,  System.currentTimeMillis()+"_swf.swf"));
		} else {
			throw new IOException("not a common file");
		}
		fileToPdf();
		convertPDF2SWF();
		return destSwfFile;
	}

	private int convertPDF2SWF() throws IOException {
		String command = BATFILE + " " + destPdfFile.getAbsolutePath() + " "
				+ destSwfFile.getAbsolutePath();
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

	/**
	 * convert Doc file to pdf file.
	 * 
	 * @param docFile
	 * @param pdfFile
	 * @throws ConnectException
	 */
	private void fileToPdf() throws ConnectException {

		// connect to an OpenOffice.org instance running on port 8100

		try {
			if (connection == null || !connection.isConnected()) {
				connection = new SocketOpenOfficeConnection(8100);
				connection.connect();
			}
			// convert
			DocumentConverter converter = new OpenOfficeDocumentConverter(
					connection);
			converter.convert(sourceFile, destPdfFile);
		} catch (ConnectException cex) {
			cex.printStackTrace();
			throw cex;
		}
	}

	public static void main(String[] args) throws Exception {
		FileToSwfTool fileToSwfTool = FileToSwfTool.getFileToSwfTool();
		fileToSwfTool.convert(new File("e:\\流程图1422669756444.doc"));
	}
}
