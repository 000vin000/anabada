// userJoinIdCheck.js
$(document).ready(function() {
    $('#checkDuplicateUserId').click(function() {
        const userId = $('#userId').val();
        if (!userId) {
            showMessage('아이디를 입력해주세요.', 'red');
            return;
        }

        $.ajax({
            url: '/user/users/check-duplicate', // URL 수정
            type: 'GET',
            data: { userId: userId },
            success: function(response) {
                if (response.isDuplicate) {
                    showMessage('이미 사용 중인 아이디입니다.', 'red');
                } else {
                    showMessage('사용 가능한 아이디입니다.', 'green');
                }
            },
            error: function() {
                showMessage('중복 확인 중 오류가 발생했습니다.', 'red');
            }
        });
    });

    function showMessage(message, color) {
        $('#userIdCheckResult').text(message).css('color', color);
    }
});
