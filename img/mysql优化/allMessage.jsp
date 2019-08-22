<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%@ include file="../comm.jsp" %>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
      content="width=device-width,initial-scale=1,user-scalable=0">
<title>全部消息</title>
<script type="text/javascript">
    $(function () {
        loadMsg();
    })
    var loadMsg = function () {
        $('#content').empty();
        $.ajax({
            url: "<%=root%>/msg/getAllMsg",
            type: "POST",
            success: function (msgList) {
                $('#msgCount').empty();
                $('#msgCount').append(msgList.length);
                $('#content').empty();
                var content = ""
                for (var i = 0; i < msgList.length; i++) {
                    var msg = msgList[i];
                    content += '<a class="weui-cell weui-cell_access js_item" data-id="list" onclick="msgDetail(' + msg.rid + ')">'
                        + '<div class="weui-cell__bd">'
                        + '<p>' + msg.messageNote + '</p>'
                        + '</div>'
                        + '<div class="weui-cell__bd">'
                        + '<p align="right"">' + timestamp(msg.createDate).substr(2) + '</p>'
                        + '</div>'
                        + '<div class="weui-cell__ft"></div>'
                        + '</a>';
                }
                content += '</div>';
                $('#content').append(content);
            }
        });
    }


    var msgDetail = function (rid) {
        var msgtype;
        $.ajax({
            url: "<%=root%>/msg/msgtype/" + rid,
            type: "GET",
            async:false,
            success: function (skdtype) {
                msgtype = skdtype;
            }
        })
        $.ajax({
            url: "<%=root%>/msg/msgDetail/" + rid,
            type: "GET",
            async:false,
            success: function (note) {
                var msgnote = note;
                $.modal({
                    title: "查看详情",
                    text: msgnote,
                    buttons: [
                        {
                            text: "查看详情", onClick: function () {
                                if (msgtype == '40'){
                                    window.location.href="<%=root%>/msg/questionDetail/" + rid;
                                }else{
                                    window.location.href="<%=root%>/login/approving/" + rid;
                                }
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