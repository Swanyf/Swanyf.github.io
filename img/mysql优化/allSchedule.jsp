<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%@ include file="../comm.jsp" %>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
      content="width=device-width,initial-scale=1,user-scalable=0">
<title>全部待办事项</title>
<script type="text/javascript">
    $(function () {
        loadMsg();
    })
    var loadMsg = function () {
        $('#content').empty();
        $.ajax({
            url: "<%=root%>/msg/getAllSchedule",
            type: "POST",
            success: function (scheduleList) {
                $('#content').empty();
                var content = ""
                for (var i = 0; i < scheduleList.length; i++) {
                    var schedule = scheduleList[i];
                    content += '<a class="weui-cell weui-cell_access js_item" data-id="list" onclick="scheduleDetail(' + schedule.rid + ')">'
                        + '<div class="weui-cell__bd">'
                        + '<p>' + schedule.skdSubject + '</p>'
                        + '</div>'
                        + '<div class="weui-cell__bd">'
                        + '<p align="right">' + timestamp(schedule.createDate).substr(2) + '</p>'
                        + '</div>'
                        + '<div class="weui-cell__ft"></div>'
                        + '</a>';
                }
                content += '</div>';
                $('#content').append(content);
            }
        });
    }
    var scheduleDetail = function (rid) {
        $.ajax({
            url: "<%=root%>/msg/scheduleNote/" + rid,
            type: "GET",
            success: function (note) {
                var msgnote = note;
                $.modal({
                    title: "查看详情",
                    text: msgnote,
                    buttons: [
                        {
                            text: "查看详情", onClick: function () {
                                window.location.href="<%=root%>/msg/scheduleDetail/" + rid;
                            }
                        },
                        {
                            text: "取消", className: "default", onClick: function () {
                                $.closeModal();
                            }
                        },
                    ]
                });
            }

        });
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