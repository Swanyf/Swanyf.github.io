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
        <div class="weui-cell__ft">${notice.ntcSubject}</div>
    </div>
</div>
<div class="weui-cells">
    <div class="weui-cell">
        <div class="weui-cell__bd">
            <p>创建人</p>
        </div>
        <div class="weui-cell__ft">${notice.creator}</div>
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
            <p>内容简介</p>
        </div>
        <div class="weui-cell__ft">${notice.ntcText}</div>
    </div>
</div>
<div class="weui-cells">
    <p class="weui-cell">${notice.ntcBody}</p>
</div>
</body>
</html>
