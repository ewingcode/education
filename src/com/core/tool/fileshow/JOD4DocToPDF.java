package com.core.tool.fileshow;
/**
 * 
 */

import java.io.File;
import java.net.ConnectException;

import com.artofsolving.jodconverter.DocumentConverter;
import com.artofsolving.jodconverter.openoffice.connection.OpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.connection.SocketOpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.converter.OpenOfficeDocumentConverter;

/**
 * <ul>
 * <li>�ļ����: com.born.sys.util.pdf.JOD4DocToPDF.java</li>
 * <li>�ļ�����:</li>
 * <li>��Ȩ����: ��Ȩ����(C)2001-2006</li>
 * <li>�� ˾: born</li>
 * <li>����ժҪ:</li>
 * <li>����˵��:</li>
 * <li>������ڣ�2010-5-21</li>
 * <li>�޸ļ�¼0����</li>
 * </ul>
 * 
 * @version 1.0
 * @author ������
 */
public class JOD4DocToPDF extends java.lang.Thread {
	private File inputFile;// ��Ҫת�����ļ�
	private File outputFile;// ������ļ�

	public JOD4DocToPDF(File inputFile, File outputFile) {
		this.inputFile = inputFile;
		this.outputFile = outputFile;
	}

	public void docToPdf() {

		// connect to an OpenOffice.org instance running on port 8100
		OpenOfficeConnection connection = new SocketOpenOfficeConnection(8100);
		try {
			connection.connect();

			// convert
			DocumentConverter converter = new OpenOfficeDocumentConverter(
					connection);
			converter.convert(inputFile, outputFile);
		} catch (ConnectException cex) {
			cex.printStackTrace();
		} finally {
			// close the connection
			if (connection != null) {
				connection.disconnect();
				connection = null;
			}
		}
	}

	/**
	 * ���ڷ������̲߳���ȫ�ģ����ԡ�����Ҫ�����߳�
	 */
	public void run() {
		this.docToPdf();

	}

	public File getInputFile() {
		return inputFile;
	}

	public void setInputFile(File inputFile) {
		this.inputFile = inputFile;
	}

	public File getOutputFile() {
		return outputFile;
	}

	public void setOutputFile(File outputFile) {
		this.outputFile = outputFile;
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		JOD4DocToPDF tools = new JOD4DocToPDF(new File("d:/A.doc"), new File(
				"d:/C122.pdf"));
		tools.start();

	}

}