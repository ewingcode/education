package com.web.action;

import java.io.File;
import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.core.app.action.base.ActionException;
import com.core.app.action.base.BaseAction;
import com.core.app.action.base.ResponseData;
import com.core.app.action.base.ResponseUtils;
import com.core.app.bean.UserInfo;
import com.core.app.control.SessionControl;
import com.core.app.service.BaseModelService;
import com.core.jdbc.DaoException;
import com.web.constant.OrderAttachStatus;
import com.web.constant.OrderCourseOper;
import com.web.model.OrderAttach;
import com.web.model.OrderCourse;
import com.web.model.OrderInfo;
import com.web.model.OrderRelHis;
import com.web.service.OrderAttachService;
import com.web.service.OrderCourseService;
import com.web.service.OrderLastService;
import com.web.service.OrderRelHisService;
import com.web.service.OrderService;

/**
 * @author Administrator
 * 
 */
public class OrderControlAction extends BaseAction {
	private static Logger logger = Logger.getLogger(OrderControlAction.class);

	public OrderControlAction() {
		super(OrderInfo.class);
	}

	// File1
	private File uploadfile1;
	private String uploadfile1FileName;
	private String uploadfile1ContentType;
	private String uploadStatus1;
	private String uploadCommet1;
	// File2
	private File uploadfile2;
	private String uploadfile2FileName;
	private String uploadfile2ContentType;
	private String uploadStatus2;
	private String uploadCommet2;
	// File3
	private File uploadfile3;
	private String uploadfile3FileName;
	private String uploadfile3ContentType;
	private String uploadStatus3;
	private String uploadCommet3;
	// File4
	private File uploadfile4;
	private String uploadfile4FileName;
	private String uploadfile4ContentType;
	private String uploadStatus4;
	private String uploadCommet4;
	// File5
	private File uploadfile5;
	private String uploadfile5FileName;
	private String uploadfile5ContentType;
	private String uploadStatus5;
	private String uploadCommet5;
	// File6
	private File uploadfile6;
	private String uploadfile6FileName;
	private String uploadfile6ContentType;
	private String uploadStatus6;
	private String uploadCommet6;

	@Resource
	private OrderAttachService orderAttachService;
	@Resource
	private OrderCourseService orderCourseService;
	@Resource
	private OrderService orderService;
	@Resource
	private OrderLastService orderLastService;
	@Resource
	private OrderRelHisService orderRelHisService;
	@Resource
	private BaseModelService baseModelService;

	private Map<OrderAttach, File> uploadAttachFile(int studentId)
			throws Exception {
		Map<OrderAttach, File> attachMap = new HashMap<OrderAttach, File>();
		Field[] fields = OrderControlAction.class.getDeclaredFields();
		for (Field field : fields) {
			String fieldName = field.getName();
			if (fieldName.startsWith("uploadfile")) {
				try {
					String type = fieldName.replace("uploadfile", "");
					Object fileObject = OrderControlAction.class
							.getDeclaredField("uploadfile" + type).get(this);
					if (fileObject == null)
						continue;
					if (!(fileObject instanceof File))
						continue;
					File uploadFile = (File) fileObject;
					String uploadFileName = (String) OrderControlAction.class
							.getDeclaredField("uploadfile" + type + "FileName")
							.get(this);
					OrderAttach orderAttach = new OrderAttach();
					orderAttach.setName(uploadFileName);
					orderAttach.setType(type);
					orderAttach.setStatus(OrderAttachStatus.WAIT);
					attachMap.put(orderAttach, uploadFile);
				} catch (Exception e) {
					logger.error(e, e);
					throw e;
				}
			}

		}
		return attachMap;
	}

	private Map<OrderAttach, File> applyAttachFile(int orderId)
			throws Exception {
		Map<OrderAttach, File> attachMap = new HashMap<OrderAttach, File>();
		Field[] fields = OrderControlAction.class.getDeclaredFields();
		for (Field field : fields) {
			String fieldName = field.getName();
			if (fieldName.startsWith("uploadStatus")) {
				try {
					// 取属性最后一位数字作文件类型
					String type = fieldName.replace("uploadStatus", "");
					String status = (String) field.get(this);
					if (OrderAttachStatus.ACCEPT.equals(status)
							|| OrderAttachStatus.REJECT.equals(status)) {
						String commet = (String) OrderControlAction.class
								.getDeclaredField("uploadCommet" + type).get(
										this);
						OrderAttach orderAttach = orderAttachService
								.getOrderAttach(orderId, type);
						orderAttach.setCommet(commet);
						orderAttach.setStatus(status);
						attachMap.put(orderAttach, null);
					}
				} catch (Exception e) {
					logger.error(e, e);
					throw e;
				}
			}
		}
		return attachMap;
	}

	private List<OrderCourse> processOrderCourse(int orderId,
			OrderCourseOper oper) {
		Map paramMap = request.getParameterMap();
		Iterator itor = paramMap.keySet().iterator();
		String statusPrefix = "courseStatus";
		String chargerPrefix = "courseChargerId";
		List<OrderCourse> courseList = new ArrayList<OrderCourse>();
		while (itor.hasNext()) {
			String key = (String) itor.next();
			// 处理审批的课程
			if (OrderCourseOper.APPLY.equals(oper)) {
				if (key.startsWith(statusPrefix)) {
					String courseType = key.replace(statusPrefix, "");
					Object object = paramMap.get(key);
					if (object == null)
						continue;
					String courseStatus = ((String[]) paramMap.get(key))[0];
					OrderCourse course = orderCourseService.getOrderCourse(
							orderId, courseType);
					course.setStatus(courseStatus);
					courseList.add(course);
				}
			}
			// 处理选择授课老师
			else if (OrderCourseOper.CHARGER.equals(oper)) {
				if (key.startsWith(chargerPrefix)) {
					String courseType = key.replace(chargerPrefix, "");
					Object object = paramMap.get(key);
					if (object == null)
						continue;
					String chargerId = ((String[]) paramMap.get(key))[0];
					OrderCourse course = orderCourseService.getOrderCourse(
							orderId, courseType);
					course.setChargerId(Integer.valueOf(chargerId));
					courseList.add(course);
				}
			}
		}
		return courseList;
	}

	public void modifyOrderCharger() throws ActionException {
		ResponseData responseData = null;
		try {
			String orderId = request.getParameter("orderId");
			Map paramMap = request.getParameterMap();
			Iterator itor = paramMap.keySet().iterator();
			String chargerPrefix = "operator";
			List<OrderRelHis> orderRelHisList = new ArrayList<OrderRelHis>();
			while (itor.hasNext()) {
				String key = (String) itor.next();
				if (key.startsWith(chargerPrefix)) {
					String chargerType = key.replace(chargerPrefix, "");
					Object object = paramMap.get(key);
					if (object == null)
						continue;
					String operator = ((String[]) paramMap.get(key))[0];
					List<OrderRelHis> list = orderRelHisService.getOrderRelHis(
							Integer.valueOf(orderId), chargerType);
					for (OrderRelHis orderRelHis : list) {
						orderRelHis.setOperator(Integer.valueOf(operator));
						orderRelHisList.add(orderRelHis);
					}
				}
			}
			orderRelHisService.batchUpdate(orderRelHisList);
			responseData = ResponseUtils.success("处理成功！");
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("处理失败！");
		}
		outResult(responseData);
	}

	private List<OrderCourse> processOrderCourse() {
		Map paramMap = request.getParameterMap();
		Iterator itor = paramMap.keySet().iterator();
		String statusPrefix = "courseStatus";
		String chargerPrefix = "courseChargerId";
		List<OrderCourse> courseList = new ArrayList<OrderCourse>();
		while (itor.hasNext()) {
			String key = (String) itor.next();
			if (key.startsWith(chargerPrefix)) {
				String courseType = key.replace(chargerPrefix, "");
				Object object = paramMap.get(key);
				if (object == null)
					continue;
				String chargerId = ((String[]) paramMap.get(key))[0];
				OrderCourse course = new OrderCourse();
				course.setCourseType(courseType);
				course.setChargerId(Integer.valueOf(chargerId));
				courseList.add(course);
			}

		}
		return courseList;
	}
	public static void main(String[] args) {
		String fee = "5634";

		BigDecimal feeBD = new BigDecimal(fee);
		System.out.println(feeBD.multiply(new BigDecimal(100)).longValue());
		System.out.println(feeBD.divide(new BigDecimal(100)).doubleValue());

	}
	public void createNewOrder() throws ActionException {
		ResponseData responseData = null;
		try {
			String studentId = request.getParameter("studentId");
			String courseList = request.getParameter("courseList");
			String fee = request.getParameter("fee");

			String[] courseArray = StringUtils.split(courseList, ",");
			String courseHour = request.getParameter("courseHour");
			String grade = request.getParameter("grade");
			OrderInfo orderInfo = new OrderInfo();
			orderInfo.setStudentId(Integer.valueOf(studentId));
			orderInfo.setGrade(grade);
			orderInfo.setCourseHour(Integer.valueOf(courseHour));
			orderInfo = (OrderInfo) this.buildPageData(super.entityBean);
			UserInfo userInfo = SessionControl.getUserInfo(request);
			Map<OrderAttach, File> attachMap = uploadAttachFile(this);
			List<OrderInfo> orderList = orderService.findByOrderNo(orderInfo
					.getOrderNo());
			if (orderList != null && !orderList.isEmpty()) {
				responseData = ResponseUtils.fail("有重复的合同编号！");
				outResult(responseData);
				return;
			}
			BigDecimal feeBD = new BigDecimal(fee); 
			orderInfo.setFee(feeBD.multiply(new BigDecimal(100)).longValue()); 
			orderService.createNewOrder(orderInfo, userInfo.getId(), attachMap,
					courseArray);

			responseData = ResponseUtils.success("创建签单成功！");
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("创建签单失败！");
		}
		outResult(responseData);

	}

	/**
	 * 提交
	 * 
	 * @throws ActionException
	 */

	public void submit() throws ActionException {
		ResponseData responseData = null;
		try {

			String req_submitType = request.getParameter("submitType");
			String req_assignerId = request.getParameter("assignerId");
			String courseList = request.getParameter("courseList");
			String[] courseArray = StringUtils.split(courseList, ",");
			String req_orderId = request.getParameter("orderId");
			String req_transitionName = request.getParameter("transitionName");
			String req_courseOper = request.getParameter("courseOper");
			String req_isOnlyEdit = request.getParameter("isOnlyEdit");
			boolean isOnlyEdit = req_isOnlyEdit != null
					&& Boolean.valueOf(req_isOnlyEdit) ? true : false;
			int orderId = Integer.valueOf(req_orderId);
			Map<OrderAttach, File> attachMap = new HashMap<OrderAttach, File>();
			// 是否处理上传文件
			if (SubmitType.UPLOAD_FILE.getType().equals(req_submitType)) {
				attachMap = uploadAttachFile(orderId);
			} else if (SubmitType.APPLY_FILE.getType().equals(req_submitType)) {
				attachMap = applyAttachFile(orderId);
			}
			OrderInfo orderInfo = baseModelService.findOne(orderId,
					OrderInfo.class);
			this.buildPageData(orderInfo);
			List<OrderCourse> courseListStatus = processOrderCourse(orderId,
					OrderCourseOper.getOrderCourseOper(req_courseOper));
			UserInfo userInfo = SessionControl.getUserInfo(request);
			int operator = userInfo.getId();
			int assignerId = StringUtils.isEmpty(req_assignerId) ? 0 : Integer
					.valueOf(req_assignerId);
			orderService.orderEdit(orderInfo, courseArray, operator, orderId,
					courseListStatus, attachMap);
			if (!isOnlyEdit) {
				orderService.orderTransfer(userInfo.getId(), assignerId,
						orderId, req_transitionName);
			}

			responseData = ResponseUtils.success("处理成功！");
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("处理失败！");
		}
		outResult(responseData);
	}

	/**
	 * 撤单
	 * 
	 * @throws ActionException
	 */

	public void cancelOrder() throws ActionException {
		ResponseData responseData = null;
		try {

			String req_orderId = request.getParameter("orderId");
			orderService.cancelOrder(Integer.valueOf(req_orderId));
			responseData = ResponseUtils.success("撤单成功！");
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("撤单失败！");
		}
		outResult(responseData);
	}

	/**
	 * 继单
	 * 
	 * @throws ActionException
	 */
	public void lastOrder() throws ActionException {
		ResponseData responseData = null;
		try {
			String studentId = request.getParameter("studentId");
			String courseHour = request.getParameter("courseHour");
			String parentOrderId = request.getParameter("parentOrderId");
			String grade = request.getParameter("grade");
			String req_isOnlyEdit = request.getParameter("isOnlyEdit");
			boolean isOnlyEdit = req_isOnlyEdit != null
					&& Boolean.valueOf(req_isOnlyEdit) ? true : false;
			OrderInfo orderInfo = new OrderInfo();
			orderInfo.setParentOrderId(Integer.valueOf(parentOrderId));
			if (isOnlyEdit) {
				orderInfo = orderService.findOne(orderInfo.getParentOrderId());
			} else {
				orderInfo = (OrderInfo) this.buildPageData(super.entityBean);
			}
			orderInfo.setStudentId(Integer.valueOf(studentId));
			orderInfo.setGrade(grade);
			orderInfo.setCourseHour(Integer.valueOf(courseHour));
			UserInfo userInfo = SessionControl.getUserInfo(request);
			Map<OrderAttach, File> attachMap = uploadAttachFile(this);
			List<OrderCourse> courseList = processOrderCourse();
			orderLastService.lastOrder(userInfo.getId(), orderInfo, attachMap,
					courseList, isOnlyEdit);
			responseData = ResponseUtils.success("处理成功！");
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("处理失败！");
		}
		outResult(responseData);

	}

	/**
	 * 编辑
	 * 
	 * @throws ActionException
	 */
	public void editOrder() throws ActionException {
		ResponseData responseData = null;
		try {
			String orderId = request.getParameter("orderId");
			String studentId = request.getParameter("studentId");
			String courseHour = request.getParameter("courseHour");
			String grade = request.getParameter("grade");
			boolean isOnlyEdit = true;
			OrderInfo orderInfo = orderService
					.findOne(Integer.valueOf(orderId));
			orderInfo.setStudentId(Integer.valueOf(studentId));
			orderInfo.setGrade(grade);
			orderInfo.setCourseHour(Integer.valueOf(courseHour));
			UserInfo userInfo = SessionControl.getUserInfo(request);
			Map<OrderAttach, File> attachMap = uploadAttachFile(this);
			List<OrderCourse> courseList = processOrderCourse();
			orderService.editOrder(userInfo.getId(), orderInfo, attachMap,
					courseList, isOnlyEdit);
			responseData = ResponseUtils.success("处理成功！");
		} catch (Exception e) {
			logger.error(e, e);
			responseData = ResponseUtils.fail("处理失败！");
		}
		outResult(responseData);

	}

	public String getUploadStatus1() {
		return uploadStatus1;
	}

	public void setUploadStatus1(String uploadStatus1) {
		this.uploadStatus1 = uploadStatus1;
	}

	public String getUploadCommet1() {
		return uploadCommet1;
	}

	public void setUploadCommet1(String uploadCommet1) {
		this.uploadCommet1 = uploadCommet1;
	}

	public String getUploadStatus2() {
		return uploadStatus2;
	}

	public void setUploadStatus2(String uploadStatus2) {
		this.uploadStatus2 = uploadStatus2;
	}

	public String getUploadCommet2() {
		return uploadCommet2;
	}

	public void setUploadCommet2(String uploadCommet2) {
		this.uploadCommet2 = uploadCommet2;
	}

	public File getUploadfile3() {
		return uploadfile3;
	}

	public void setUploadfile3(File uploadfile3) {
		this.uploadfile3 = uploadfile3;
	}

	public String getUploadfile3FileName() {
		return uploadfile3FileName;
	}

	public void setUploadfile3FileName(String uploadfile3FileName) {
		this.uploadfile3FileName = uploadfile3FileName;
	}

	public String getUploadfile3ContentType() {
		return uploadfile3ContentType;
	}

	public void setUploadfile3ContentType(String uploadfile3ContentType) {
		this.uploadfile3ContentType = uploadfile3ContentType;
	}

	public String getUploadStatus3() {
		return uploadStatus3;
	}

	public void setUploadStatus3(String uploadStatus3) {
		this.uploadStatus3 = uploadStatus3;
	}

	public String getUploadCommet3() {
		return uploadCommet3;
	}

	public void setUploadCommet3(String uploadCommet3) {
		this.uploadCommet3 = uploadCommet3;
	}

	public File getUploadfile4() {
		return uploadfile4;
	}

	public void setUploadfile4(File uploadfile4) {
		this.uploadfile4 = uploadfile4;
	}

	public String getUploadfile4FileName() {
		return uploadfile4FileName;
	}

	public void setUploadfile4FileName(String uploadfile4FileName) {
		this.uploadfile4FileName = uploadfile4FileName;
	}

	public String getUploadfile4ContentType() {
		return uploadfile4ContentType;
	}

	public void setUploadfile4ContentType(String uploadfile4ContentType) {
		this.uploadfile4ContentType = uploadfile4ContentType;
	}

	public String getUploadStatus4() {
		return uploadStatus4;
	}

	public void setUploadStatus4(String uploadStatus4) {
		this.uploadStatus4 = uploadStatus4;
	}

	public String getUploadCommet4() {
		return uploadCommet4;
	}

	public void setUploadCommet4(String uploadCommet4) {
		this.uploadCommet4 = uploadCommet4;
	}

	public File getUploadfile5() {
		return uploadfile5;
	}

	public void setUploadfile5(File uploadfile5) {
		this.uploadfile5 = uploadfile5;
	}

	public String getUploadfile5FileName() {
		return uploadfile5FileName;
	}

	public void setUploadfile5FileName(String uploadfile5FileName) {
		this.uploadfile5FileName = uploadfile5FileName;
	}

	public String getUploadfile5ContentType() {
		return uploadfile5ContentType;
	}

	public void setUploadfile5ContentType(String uploadfile5ContentType) {
		this.uploadfile5ContentType = uploadfile5ContentType;
	}

	public String getUploadStatus5() {
		return uploadStatus5;
	}

	public void setUploadStatus5(String uploadStatus5) {
		this.uploadStatus5 = uploadStatus5;
	}

	public String getUploadCommet5() {
		return uploadCommet5;
	}

	public void setUploadCommet5(String uploadCommet5) {
		this.uploadCommet5 = uploadCommet5;
	}

	public File getUploadfile6() {
		return uploadfile6;
	}

	public void setUploadfile6(File uploadfile6) {
		this.uploadfile6 = uploadfile6;
	}

	public String getUploadfile6FileName() {
		return uploadfile6FileName;
	}

	public void setUploadfile6FileName(String uploadfile6FileName) {
		this.uploadfile6FileName = uploadfile6FileName;
	}

	public String getUploadfile6ContentType() {
		return uploadfile6ContentType;
	}

	public void setUploadfile6ContentType(String uploadfile6ContentType) {
		this.uploadfile6ContentType = uploadfile6ContentType;
	}

	public String getUploadStatus6() {
		return uploadStatus6;
	}

	public void setUploadStatus6(String uploadStatus6) {
		this.uploadStatus6 = uploadStatus6;
	}

	public String getUploadCommet6() {
		return uploadCommet6;
	}

	public void setUploadCommet6(String uploadCommet6) {
		this.uploadCommet6 = uploadCommet6;
	}

	public File getUploadfile1() {
		return uploadfile1;
	}

	public void setUploadfile1(File uploadfile1) {
		this.uploadfile1 = uploadfile1;
	}

	public String getUploadfile1FileName() {
		return uploadfile1FileName;
	}

	public void setUploadfile1FileName(String uploadfile1FileName) {
		this.uploadfile1FileName = uploadfile1FileName;
	}

	public String getUploadfile1ContentType() {
		return uploadfile1ContentType;
	}

	public void setUploadfile1ContentType(String uploadfile1ContentType) {
		this.uploadfile1ContentType = uploadfile1ContentType;
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

	enum SubmitType {
		NOTHING("0"), APPLY_FILE("1"), UPLOAD_FILE("2");
		private String type;

		SubmitType(String type) {
			this.type = type;
		}

		String getType() {
			return this.type;
		}
	}
}