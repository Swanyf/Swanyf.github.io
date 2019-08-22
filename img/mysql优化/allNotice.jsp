<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%@ include file="../comm.jsp" %>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
      content="width=device-width,initial-scale=1,user-scalable=0">
<title>全部新闻通知</title>
<script type="text/javascript">
    $(function () {
        loadMsg();
    })
    var loadMsg = function () {
        $('#content').empty();
        $.ajax({
            url: "<%=root%>/msg/getAllNotice",
            type: "POST",
            success: function (noticeList) {
                $('#content').empty();
                var content = ""
                for (var i = 0; i < noticeList.length; i++) {
                    var notice = noticeList[i];
                    var type;
                    if(notice.ntcType == 0){
                        type = "[通知]";
                    }
                    if(notice.ntcType == 1){
                        type = "[新闻]";
                    }
                    content += '<a class="weui-cell weui-cell_access js_item" data-id="list" onclick="noticeDetail(' + notice.rid + ')">'
                        + '<div class="weui-cell__bd">'
                        + '<p>' + type + notice.ntcSubject + '</p>'
                        + '</div>'
                        + '<div class="weui-cell__bd">'
                        + '<p align="right">' + timestamp(notice.createDate).substr(2) + '</p>'
                        + '</div>'
                        + '<div class="weui-cell__ft"></div>'
                        + '</a>';
                }
                content += '</div>';
                $('#content').append(content);
            }
        });
    }

    var noticeDetail = function (rid) {
        window.location.href = "<%=root%>/msg/noticeDetail/" + rid;
    }
    var timestamp = function(timestamp) {
        var date = new Date(timestamp);
        var Y = date.getFullYear() + '-';
        var M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
        var D = date.getDate() + ' ';
        var h = date.getHours() + ':';
        var m = date.getMinutes() + ':';
        var s = date.getSeconds();
        return Y+M+D+h+m+s;
    }
</script>
</head>
<body ontouchstart>
    <div class="weui-tab__panel" id='content'>
    </div>
</body>
</html>