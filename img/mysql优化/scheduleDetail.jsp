<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%@ include file="../comm.jsp" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,user-scalable=0">
    <title>详情</title>
</head>
<script type="text/javascript">

</script>
<body ontouchstart>
<div class="weui-cells">
    <div class="weui-cell">
        <div class="weui-cell__bd">
            <p>主题</p>
        </div>
        <div class="weui-cell__ft">${oaSchedules.getSkdSubject()}</div>
    </div>
</div>
<div class="weui-cells">
    <div class="weui-cell">
        <div class="weui-cell__bd">
            <p>内容</p>
        </div>
        <div class="weui-cell__ft">${oaSchedules.getSkdNote()}</div>
    </div>
</div>
<div class="weui-cells">
    <div class="weui-cell">
        <div class="weui-cell__bd">
            <p>创建时间</p>
        </div>
        <div class="weui-cell__ft">${createDate}</div>
    </div>
</div>
<div class="weui-cells">
    <div class="weui-cell">
        <div class="weui-cell__bd">
            <p>开始时间</p>
        </div>
        <div class="weui-cell__ft">${DateFrom}</div>
    </div>
</div>
<div class="weui-cells">
    <div class="weui-cell">
        <div class="weui-cell__bd">
            <p>结束时间</p>
        </div>
        <div class="weui-cell__ft">${DateTo}</div>
    </div>
</div>
</body>
</html>