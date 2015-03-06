package com.web.action;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;

import com.core.app.action.base.BaseAction;

public class UploadFileAction extends BaseAction {

	private File uploadfile2;
	// 使用列表保存多个上传文件的文件名
	private String uploadfile2FileName;
	// 使用列表保存多个上传文件的MIME类型
	private String uploadfile2ContentType;
	private void apacheUpload() {
		DiskFileUpload fu = new DiskFileUpload();
		// 最多上传3G的数据
		fu.setSizeMax(1024 * 1024 * 1024 * 3);
		// 超过1M的字段数据采用临时文件缓存
		fu.setSizeThreshold(1024 * 1024);
		// 采用默认的临时文件存储位置
		// fu.setRepositoryPath(...);
		// 设置上传的普通字段的名称和文件字段的文件名所采用的字符集编码
		fu.setHeaderEncoding("utf-8");

		// 得到所有表单字段对象的集合
		List fileItems = null;
		try {
			fileItems = fu.parseRequest(request);
		} catch (FileUploadException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		// 处理每个表单字段
		Iterator i = fileItems.iterator();
		String targetName = null;// 目标文件名
		while (i.hasNext()) {
			FileItem fi = (FileItem) i.next();
			if (!fi.isFormField()) {
				try {
					String pathSrc = fi.getName();// 获取上传文件路径
					pathSrc = new String(pathSrc.getBytes("ISO-8859-1"),
							"UTF-8");
					if (pathSrc.trim().equals("")) {
						continue;
					}
					int start = pathSrc.lastIndexOf('\\');
					String tempName = pathSrc.substring(start + 1);// 获取上传文件名
					String fileName = "1212121";// 新的文件名

					if (tempName.indexOf(".") < 0) {// 如果文件没有后缀
						targetName = fileName;
					} else {
						int index = tempName.lastIndexOf(".");
						targetName = fileName + tempName.substring(index);// fileName+文件后缀
					}

					File pathDest = new File("d\\", targetName);
					fi.write(pathDest);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} finally {
					fi.delete();
				}

			}
		}
	}
	public void upload() {
		apacheUpload();

		try {
			InputStream in = null;
			OutputStream out = null;
			File detfile = new File("d:\\fileupload\\" + uploadfile2FileName);
			int BUFFER_SIZE = 9999;
			try {
				in = new BufferedInputStream(new FileInputStream(uploadfile2),
						BUFFER_SIZE);
				out = new BufferedOutputStream(new FileOutputStream(detfile),
						BUFFER_SIZE);
				byte[] buffer = new byte[BUFFER_SIZE];
				while (in.read(buffer) > 0) {
					out.write(buffer);
				}
			} finally {
				if (null != in) {
					in.close();
				}
				if (null != out) {
					out.close();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public File getUploadfile2() {
		return uploadfile2;
	}

	public void setUploadfile2(File uploadfile2) {
		this.uploadfile2 = uploadfile2;
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

}
