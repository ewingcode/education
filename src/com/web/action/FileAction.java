package com.web.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.lang.time.DateUtils;
import org.apache.struts2.ServletActionContext;

import com.core.app.action.base.BaseAction;

public class FileAction extends BaseAction {

	private File uploadfile2;
	// 使用列表保存多个上传文件的文件名
	private String uploadfile2FileName;
	// 使用列表保存多个上传文件的MIME类型
	private String uploadfile2ContentType;

	private InputStream inputStream;

	private String fileName;
	
	private String downTargetPath;

	public String getDownTargetPath() {
		return downTargetPath;
	}

	public void setDownTargetPath(String downTargetPath) {
		this.downTargetPath = downTargetPath;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getUploadfile2FileName() {
		return uploadfile2FileName;
	}

	public void setUploadfile2FileName(String uploadfile2FileName) {
		this.uploadfile2FileName = uploadfile2FileName;
	}

	public String getUploadfile2ContentType() {
		return uploadfile2ContentType;
	}

	public void setUploadfile2ContentType(String uploadfile2ContentType) {
		this.uploadfile2ContentType = uploadfile2ContentType;
	}

	private List<File> uploadfile;
	// 使用列表保存多个上传文件的文件名
	private List<String> uploadfileFileName;
	// 使用列表保存多个上传文件的MIME类型
	private List<String> uploadfileContentType;

	

	public void upload() { 
		// try {
		// InputStream in = null;
		// OutputStream out = null;
		// File detfile = new File("d:\\fileupload\\" + uploadfile2FileName);
		// int BUFFER_SIZE = 9999;
		// try {
		// in = new BufferedInputStream(new FileInputStream(uploadfile2),
		// BUFFER_SIZE);
		// out = new BufferedOutputStream(new FileOutputStream(detfile),
		// BUFFER_SIZE);
		// byte[] buffer = new byte[BUFFER_SIZE];
		// while (in.read(buffer) > 0) {
		// out.write(buffer);
		// }
		// } finally {
		// if (null != in) {
		// in.close();
		// }
		// if (null != out) {
		// out.close();
		// }
		// }
		// } catch (Exception e) {
		// e.printStackTrace();
		// }

	}

	public InputStream getDownloadFile() throws Exception {
		String filePath = ServletActionContext.getServletContext().getRealPath(
				"user.gif");
		return new FileInputStream(new File(filePath));
	}

	// Action调用的下载文件方法
	public String down() {
		return "down";
	}

	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}

	// //获得下载文件的内容，可以直接读入一个物理文件或从数据库中获取内容
	public InputStream getInputStream() throws Exception {
		//File file = new File("d:\\A.doc");
		String fileRealPath = ServletActionContext.getServletContext().getRealPath(
				downTargetPath);
		File file = new File(fileRealPath);
		fileName = file.getName();
		if (file.exists()) {
			inputStream = new FileInputStream(file);
		}
		return inputStream;
	}

	public String getFileName() throws UnsupportedEncodingException {
		try {
			// 中文文件名也是需要转码为 ISO8859-1，否则乱码
			return new String(fileName.getBytes(), "ISO8859-1");
		} catch (UnsupportedEncodingException e) {
			throw new UnsupportedEncodingException("不支持该类型文件！");
		}

	}

	public File getUploadfile2() {
		return uploadfile2;
	}

	public void setUploadfile2(File uploadfile2) {
		this.uploadfile2 = uploadfile2;
	}

	public List<File> getUploadfile() {
		return uploadfile;
	}

	public void setUploadfile(List<File> uploadfile) {
		this.uploadfile = uploadfile;
	}

	public List<String> getUploadfileFileName() {
		return uploadfileFileName;
	}

	public void setUploadfileFileName(List<String> uploadfileFileName) {
		this.uploadfileFileName = uploadfileFileName;
	}

	public List<String> getUploadfileContentType() {
		return uploadfileContentType;
	}

	public void setUploadfileContentType(List<String> uploadfileContentType) {
		this.uploadfileContentType = uploadfileContentType;
	}
}
