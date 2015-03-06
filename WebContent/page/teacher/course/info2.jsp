<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/common/include/head.jsp"%> 
<c:set var="_jsFiles" value="${_cp}/page/teacher/course/schedule2.js,${_cp}/page/teacher/info/edit.js" />
<%@ include file="/common/include/html_head.jsp"%> 
<style type="text/css">
.app-header .x-panel-body {
    background-color: #ddd;
    padding-left: 5px;
}

.app-header h1 {
    font-family: verdana,arial,sans-serif;
    font-size: 20px;
    color: #15428B;
}

.hospital-target {
    border: 1px solid red;
    width: 400ps;
    height: 16px;
    margin: 5px;
    padding: 5px;
}

.hospital-target.hospital-target-hover {
    background-color: #C0C0C0;
}

.patient-source {
    cursor: pointer;
}

.patient-view td {
    font-family: verdana,arial,sans-serif;
    font-size: 12px;
}

td.patient-label {
    background-color: #ddd;
    border: 1px solid #bbb;
    font-weight: bold;
    text-align: right;
    width: 100px;
    padding: 0px 3px 0px 0px;
}

.patient-over {
    background-color:#EFEFEF;
    cursor: pointer;
}
.patient-selected {
    background-color: #DFE8F6;
    cursor: pointer;
}
</style>
<body>
<div id="panel"></div>
</body>
<%@ include file="/common/include/html_bottom.jsp"%>